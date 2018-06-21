Util     = require('../libs/Util')
Resize   = require('../libs/Resize')
Size     = require('../libs/obj/Size')
Type     = require('./Type')
Conf     = require('./Conf')
Profiler = require('./Profiler')

# 共通関数
class Func

  constructor: ->



  # ------------------------------------
  # レティナのあの値
  # ------------------------------------
  ratio: =>

    if Profiler.isLow
      return 1
    else
      return Math.min(2, window.devicePixelRatio || 1)



  # ------------------------------------
  # スクリーンタイプ取得
  # ------------------------------------
  screen: =>

    if window.innerWidth <= Conf.BREAKPOINT
      return Type.SCREEN.XS
    else
      return Type.SCREEN.LG



  # ------------------------------------
  # スクリーンタイプ XS
  # ------------------------------------
  isXS: =>

    return (@screen() == Type.SCREEN.XS)



  # ------------------------------------
  # スクリーンタイプ LG
  # ------------------------------------
  isLG: =>

    return (@screen() == Type.SCREEN.LG)



  # ------------------------------------
  # スクリーンタイプで分岐
  # ------------------------------------
  val: (xs, lg) =>

    if @isXS()
      return xs
    else
      return lg



  # ------------------------------------
  # コクのあるサイン 1
  # ------------------------------------
  sin1: (radian) =>

    return Math.sin(radian) + Math.sin(2 * radian)



  # ------------------------------------
  # コクのあるサイン 2
  # ------------------------------------
  sin2: (radian) =>

    return (
      Math.sin(radian) +
      Math.sin(2.2 * radian + 5.52) +
      Math.sin(2.9 * radian + 0.93) +
      Math.sin(4.6 * radian + 8.94)
    ) / 4






module.exports = new Func()
