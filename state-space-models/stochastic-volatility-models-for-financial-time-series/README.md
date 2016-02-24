#  Stochastic volatility models for financial time series

Filed under:  [Finance][1]

Stochastic volatility models are used in mathematical finance to describe the evolution of asset returns, which typically exhibit changing variances over time.

### Model description

 

The dataset is  previously analyzed by [Harvey et al. (1994)][2], and later by several other authors. The data consist of a time series of daily poundollar exchange rates {_zt_} from the period 0181 to 285. The series of interest are the daily mean-corrected returns {_yt_}, given by the transformation

 

_yt_ = log(_zt_)-log(_zt-1_) \- average[log_zi_-log_zi-1_].

 

The stochastic volatility model allows the variance of _yt_ to vary smoothly with time. This is achieved by assuming that _yt_ ~ N(0,_st_), where _st_ = exp{-0.5(_mx_ _xt_)}. Here, the smoothly varying component _xt_ is assumed to be an autoregression.

 

### Details   

 [sdv.pdf][3]

### Files

See "Navigation" box to the left.

* .tpl:  Model file
* .dat: Data file
* .pin: Starting values for the numerical optimizer  
* .par: Result file (what you get when you compile and run your model)  

 

[1]: http/www.admb-project.or@@search?Subject:list=Finance
[2]: citations.html#harv:ruiz:shep:1994
[3]: sdv.pdf "sdv.pdf"
