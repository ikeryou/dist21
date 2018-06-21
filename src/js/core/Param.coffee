dat    = require('dat-gui')
Conf   = require('./Conf')
Func   = require('./Func')
Type   = require('./Type')
Update = require('../libs/Update')
Resize = require('../libs/Resize')
Size   = require('../libs/obj/Size')


# ---------------------------------------------------
# パラメータ
# ---------------------------------------------------
class Param

  constructor: ->

    @_gui

    @all = {
      bgColor:{value:0x000000}
    }

    @light = {
      move:{value:true}
    }

    @mesh = {
      move:{value:10, min:0, max:50}
      # around:{value:true}
      small:{value:true}
      guruguru:{value:true}

      noise:{value:true}
      color:{value:true}
      easing:{value:'Elastic', list:[
        'Expo',
        'Elastic'
      ], use:false}
    }

    @dom = {
      ttl:{value:true}
    }

    @posteffect = {
      invert:{value:false}
      r:{value:100, min:0, max:200}
      g:{value:100, min:0, max:200}
      b:{value:100, min:0, max:200}
    }


    @_init()



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  _init: =>

    Update.add(@_update)

    if Conf.FLG.PARAM


      # 初期値
      @all.bgColor.value = 0xffffff
      @light.move.value = false
      @mesh.move.value = 0
      # @mesh.around.value = false
      @mesh.guruguru.value = false
      @mesh.small.value = false
      @mesh.noise.value = false
      @mesh.color.value = false
      @dom.ttl.value = false

    @_gui = new dat.GUI()
    @_addGui(@mesh, 'mesh')
    @_addGui(@all, 'all')
    @_addGui(@light, 'light')
    @_addGui(@dom, 'dom')
    @_addGui(@posteffect, 'posteffect')

    $('.dg').css('zIndex', 99999999)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _addGui: (obj, folderName) =>

    folder = @_gui.addFolder(folderName)

    for key,val of obj
      if !val.use?
        if key.indexOf('Color') > 0
          folder.addColor(val, 'value').name(key)
        else
          if val.list?
            folder.add(val, 'value', val.list).name(key)
          else
            folder.add(val, 'value', val.min, val.max).name(key)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _listen: (param, name) =>

    if !name? then name = param
    @_gui.add(@, param).name(name).listen()










module.exports = new Param()
