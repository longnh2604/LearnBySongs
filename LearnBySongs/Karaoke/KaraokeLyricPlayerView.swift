//
//  KaraokeLyricPlayerView.swift
//  LearnBySongs
//
//  Created by Long on 2018/06/08.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

let kVTLyricPlayerPadding:CGFloat  =    8.0

@objc protocol LyricPlayerViewDataSource:class {
    
    func timesForLyricPlayerView(playerView: KaraokeLyricPlayerView) -> Array<CGFloat>
    func lyricPlayerView(playerView: KaraokeLyricPlayerView, atIndex:NSInteger) -> KaraokeLyricLabel
    
    @objc optional func lengthOfLyricPlayerView(playerView: KaraokeLyricPlayerView) -> CFTimeInterval
    
    func lyricPlayerView(playerView: KaraokeLyricPlayerView, allowLyricAnimationAtIndex: NSInteger) -> Bool
}

@objc protocol LyricPlayerViewDelegate:class {
    @objc optional func lyricPlayerViewDidStart(playerView: KaraokeLyricPlayerView)
    @objc optional func lyricPlayerViewDidStop(playerView: KaraokeLyricPlayerView)
}

enum VTPlayerLyricPosition:Int {
    case Top, Bottom
}

class KaraokeLyricPlayerView: UIView {
    
    weak var dataSource:LyricPlayerViewDataSource?
    weak var delegate:LyricPlayerViewDelegate?
    
    var isPlaying:Bool                      = false
    
    private var timer:Timer?
    private var currentPlayTime:CFTimeInterval  = 0
    private var length:CFTimeInterval           = 0
    private var lyricTop:KaraokeLyricLabel!
    private var lyricBottom:KaraokeLyricLabel!
    private var nextLabelHaveToUpdate:VTPlayerLyricPosition = VTPlayerLyricPosition.Top
    
    private var indexTiming:NSInteger               = 0
    private var timeIntervalRemain:CFTimeInterval   = 0
    private var timingForLyric:Array<CGFloat>       = [CGFloat]()
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    
    // MARK: Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    func setup() {
        currentPlayTime = 0.0
        length          = 0.0
        timingForLyric  = [CGFloat]()
        indexTiming     = 0
        isPlaying       = false
        nextLabelHaveToUpdate = .Top
    }
    
    func setupLabels() {
        lyricTop        = KaraokeLyricLabel()
        lyricBottom     = KaraokeLyricLabel()
        
        self.addSubview(lyricTop)
        self.addSubview(lyricBottom)
        
        self.setupLabelConstraintsForPosition(pos: .Top)
        self.setupLabelConstraintsForPosition(pos: .Bottom)
    }
    
    
    
    // MARK: Helper methods
    private func showNextLabel() {
        if indexTiming >= timingForLyric.count {
            return
        }
        
        var lyricLabel:KaraokeLyricLabel!
        
        if let dataSource = self.dataSource {
            
            lyricLabel = dataSource.lyricPlayerView(playerView: self, atIndex: indexTiming)
            
            if (lyricLabel !== lyricTop && lyricLabel !== lyricBottom) {
                if(nextLabelHaveToUpdate == .Top) {
                    lyricTop = lyricLabel
                    self.addSubview(lyricTop)
                    self.setupLabelConstraintsForPosition(pos: .Top)
                } else {
                    lyricBottom = lyricLabel
                    self.addSubview(lyricBottom)
                    self.setupLabelConstraintsForPosition(pos: .Bottom)
                }
                
                nextLabelHaveToUpdate = (nextLabelHaveToUpdate == .Top) ? .Bottom : .Top
            }
            
        } else {
            lyricLabel = self.reuseLyricView()
        }
        
        lyricLabel.reset()
        lyricLabel.duration = self.calculateDurationForLyricLabel()
    }
    
    
    
    func calculateDurationForLyricLabel() -> CGFloat {
        var duration:CGFloat = 0.0
        
        if !isLastLyric() {
            let timing = timingForLyric[indexTiming]
            let nextTiming = timingForLyric[indexTiming+1]
            duration = nextTiming - timing
        }
        
        return duration
    }
    
    
    func isLastLyric() -> Bool {
        return indexTiming >= (timingForLyric.count - 1)
    }
    
    
    private func setupLabelConstraintsForPosition(pos:VTPlayerLyricPosition) {
        
        let views:Dictionary<String,UIView> = ["lyricTop": lyricTop, "lyricBottom": lyricBottom]
        let metrics:Dictionary<String, CGFloat> = ["topMargin": kVTLyricPlayerPadding, "bottomMargin": kVTLyricPlayerPadding]
        
        if pos == .Top {
            lyricTop.translatesAutoresizingMaskIntoConstraints = false
            let vTop = NSLayoutConstraint.constraints(withVisualFormat: "V:|-topMargin-[lyricTop]", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views)
            
            let centerX = NSLayoutConstraint(item: lyricTop, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            self.addConstraints(vTop)
            self.addConstraint(centerX)
        }
        
        if pos == .Bottom {
            lyricBottom.translatesAutoresizingMaskIntoConstraints = false
            let vBot = NSLayoutConstraint.constraints(withVisualFormat: "V:[lyricBottom]-bottomMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views)
            
            let centerX = NSLayoutConstraint(item: lyricBottom, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            
            self.addConstraints(vBot)
            self.addConstraint(centerX)
        }
    }
    
    
    
    // MARK: Main methods
    func reuseLyricView() -> KaraokeLyricLabel {
        let reusedView = (nextLabelHaveToUpdate == .Top) ? lyricTop : lyricBottom
        
        nextLabelHaveToUpdate = (nextLabelHaveToUpdate == .Top) ? .Bottom : .Top
        return reusedView!
    }
    
    @objc func handleAnimationAndShowLabel(timer: Timer) {
        var isAllowedAnimation = true
        
        if let dataSource = self.dataSource {
            isAllowedAnimation = dataSource.lyricPlayerView(playerView: self, allowLyricAnimationAtIndex: indexTiming)
        }
        
        let lyricWillAnimate = (nextLabelHaveToUpdate == .Top) ? lyricBottom : lyricTop
        
        if isAllowedAnimation && !(lyricWillAnimate?.text!.isEmpty)! {
            lyricWillAnimate?.startAnimation()
        }
        
        if isLastLyric() == false {
            let timing = TimeInterval(self.calculateDurationForLyricLabel())
            //print(timing)
            
            self.timer = Timer.scheduledTimer(timeInterval: timing, target: self, selector: #selector(handleAnimationAndShowLabel(timer:)), userInfo: nil, repeats: false)
            
            indexTiming += 1
            self.showNextLabel()
        } else {
            isPlaying = false
            self.delegate?.lyricPlayerViewDidStop?(playerView: self)
        }
    }
    
    func prepareToPlay() {
        self.setup()
        
        if lyricTop == nil || lyricBottom == nil {
            self.setupLabels()
        }
        
        if let dataSource = self.dataSource {
            timingForLyric = dataSource.timesForLyricPlayerView(playerView: self)
            length = dataSource.lengthOfLyricPlayerView?(playerView: self) ?? 0
        }
        
        nextLabelHaveToUpdate = .Top
        
        self.showNextLabel()
    }
    
    func start() {
        if self.isLastLyric() {
            self.prepareToPlay()
        }
        
        if indexTiming == 0 {
            
            let timing = TimeInterval(timingForLyric[indexTiming])
            self.timer = Timer.scheduledTimer(timeInterval: timing, target: self, selector: #selector(handleAnimationAndShowLabel(timer:)), userInfo: nil, repeats: false)
            isPlaying = true;
        } else {
            self.resume()
        }
        
        self.delegate?.lyricPlayerViewDidStart?(playerView: self)
    }
    
    func resume() {
        
        if !isPlaying {
            lyricBottom.resumeAnimation()
            lyricTop.resumeAnimation()
            let timing = TimeInterval(timingForLyric[indexTiming])
            self.timer = Timer.scheduledTimer(timeInterval: timing, target: self, selector: #selector(handleAnimationAndShowLabel(timer:)), userInfo: nil, repeats: false)
            
            isPlaying = true
        }
        
    }
    
    func stop() {
        if isPlaying {
            timer?.invalidate()
            self.prepareToPlay()
            
            isPlaying = false
        }
    }
    
    func pause() {
        
        if isPlaying {
            if lyricTop.isAnimating {
                lyricTop.pauseAnimation()
            }
            
            if lyricBottom.isAnimating {
                lyricBottom.pauseAnimation()
            }
            
            if let timer = self.timer {
                timeIntervalRemain = timer.fireDate.timeIntervalSinceNow
                timer.invalidate()
                isPlaying = false;
            }
        }
    }
    
    
    
    func setCurrentTime(curTime:CFTimeInterval) {
        timer?.invalidate()
        
        var isCurrentTimeBetween2Timing = false
        
        for i in 0 ... timingForLyric.count-1 {
            let t = CFTimeInterval(timingForLyric[i])
            
            if t == curTime {
                indexTiming = i
                timeIntervalRemain = 0
                break
            } else if t > curTime {
                indexTiming = i - 1
                timeIntervalRemain = t - curTime
                isCurrentTimeBetween2Timing = true
                break
            }
        }
        
        nextLabelHaveToUpdate = (indexTiming%2 == 0) ? .Top : .Bottom
        
        if isCurrentTimeBetween2Timing {
            self.showNextLabel()
            indexTiming += 1
        }
        
        self.showNextLabel()
        
        if isPlaying {
            let timing = TimeInterval(timingForLyric[indexTiming])
            self.timer = Timer.scheduledTimer(timeInterval: timing, target: self, selector: #selector(handleAnimationAndShowLabel(timer:)), userInfo: nil, repeats: false)
        }
    }
    
    //    - (void)setCurrentTime:(CFTimeInterval)cur_time {
    //    // stop timer
    //    [timer invalidate];
    //
    //    // Find timing index
    //    // And time interval for the next lyric
    //    BOOL isCurrentTimeBetween2Timing = NO;
    //    for (NSInteger i = 0 ; i < [timingForLyric count] ; i++) {
    //    CFTimeInterval t = [[timingForLyric objectAtIndex:i] doubleValue];
    //    if (t == cur_time) {
    //    indexTiming = i;
    //    timeIntervalRemain = 0;
    //    break;
    //    } else if (t > cur_time){
    //    indexTiming = i - 1;
    //    timeIntervalRemain = t - cur_time;
    //    isCurrentTimeBetween2Timing = YES;
    //    break;
    //    }
    //    }
    //
    //    // We know nextLabelHaveToUpdate base on indexTiming
    //    nextLabelHaveToUpdate = (indexTiming%2 == 0) ? kPlayerLyricPositionTop : kPlayerLyricPositionBottom;
    //
    //    // We have to show current lable but don't need to run its animation
    //    if (isCurrentTimeBetween2Timing) {
    //    [self showNextLabel];
    //    indexTiming++;
    //    }
    //
    //    // Show next lyric
    //    [self showNextLabel];
    //
    //    if (isPlaying) {
    //    timer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalRemain target:self selector:@selector(handleAnimationAndShowLabel:) userInfo:nil repeats:NO];
    //    }
    //    }
}
