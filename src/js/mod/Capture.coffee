Func = require('../core/Func')


class Capture extends THREE.Scene

  constructor: (opt) ->

    super()

    @opt = opt || {}

    @_tgNum = @opt.num || 1
    @_texture = []
    # @_isFloat = @opt.num || 1 isFloat
    # @_isNearest = @opt.num || 1 isNearest

    @texNum = @_tgNum



  # -----------------------------------
  # 初期化
  # -----------------------------------
  init: =>

    i = 0
    while i < @_tgNum

      if @opt.param?
        o = @opt.param
      else
        o = {
          # type : if isMobile.any || !@_isFloat then THREE.UnsignedByteType else THREE.FloatType
          depthBuffer:false
          stencilBuffer:false
        }
      # if @_isNearest
      #   o.magFilter = THREE.NearestFilter
      #   o.minFilter = THREE.NearestFilter

      t = new THREE.WebGLRenderTarget(16, 16, o)

      @_texture.push(t)

      i++


  # -----------------------------------------------
  # 破棄
  # -----------------------------------------------
  dispose: =>

    for val,i in @_texture
      val.dispose()
    @_texture = null



  # -----------------------------------
  # テクスチャ
  # -----------------------------------
  texture: (key) =>

    if !key?
      key = 0

    return @_texture[key].texture



  # -----------------------------------
  # テクスチャにレンダリング
  # -----------------------------------
  render: (renderer, camera, key, isClear) =>

    if !isClear?
      isClear = true

    if !key?
      key = 0

    t = @_texture[key]

    if isClear
      renderer.clearTarget(t, true)
    renderer.render(@, camera, t)



  # -----------------------------------
  #
  # -----------------------------------
  clear: (renderer) =>

    for val,i in @_texture
      renderer.clearTarget(val, true)



  # -----------------------------------
  # レンダリング先テクスチャのサイズ設定
  # -----------------------------------
  size: (width, height) =>

    ratio = Func.ratio()

    if isMobile.any
      if width * ratio > 4096 || height * ratio > 4096
        ratio = 1

    for val,i in @_texture
      val.setSize(width * ratio, height * ratio)





module.exports = Capture
