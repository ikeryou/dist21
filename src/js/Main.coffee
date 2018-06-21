window.$                     = require('jquery')
window.THREE                 = require('three')
window.requestAnimationFrame = require('raf')
window.TweenMax              = require('gsap').TweenMax
window.CustomEase            = require('gsap').CustomEase
window.TimelineMax           = require('gsap').TimelineMax
window.isMobile              = require('ismobilejs')

Visual = require('./Visual')


class Main

  constructor: ->



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    mv = new Visual({
      el:$('.mv')
    })
    mv.init()



module.exports = Main

main = new Main()
main.init()
