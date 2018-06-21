Param   = require('../core/Param')
Conf    = require('../core/Conf')
Func    = require('../core/Func')
Util    = require('../libs/Util')
Update  = require('../libs/Update')
Resize  = require('../libs/Resize')
Capture = require('./Capture')


class PreRender

  constructor: (opt) ->

    @_opt = opt || {}

    @_camera
    @_capture



  # -----------------------------------
  # 初期化
  # -----------------------------------
  init: =>

    @_capture = new Capture(@_opt)
    @_capture.init()

    @_camera = new THREE.PerspectiveCamera(45, 1, 0.1, 50000)

    Update.add(@_update)
    Resize.add(@_resize)



  # -----------------------------------
  #
  # -----------------------------------
  getTexture: =>

    return @_capture.texture(0)



  # -----------------------------------
  #
  # -----------------------------------
  render: =>

    @_capture.render(@_opt.renderer, @_camera)



  # -----------------------------------
  #
  # -----------------------------------
  _update: =>



  # -----------------------------------
  #
  # -----------------------------------
  updateSize: (w, h) =>

    @_camera.fov = Param.camera.fov.value
    @_camera.far = Param.camera.far.value
    @_camera.near = Param.camera.near.value * 0.01
    @_updatePerspectiveCamera(@_camera, w, h)

    @_capture.size(w, h)



  # -----------------------------------
  #
  # -----------------------------------
  _resize: =>



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _updatePerspectiveCamera: (camera, w, h) =>

    w = w || 10
    h = h || 10

    camera.aspect = w / h
    camera.updateProjectionMatrix()
    camera.position.z = h / Math.tan(camera.fov * Math.PI / 360) / 2






module.exports = PreRender
