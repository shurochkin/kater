
$(document).ready ->

  # console.log window.isMobile

  checkSize = ->
    if window.orientation == 0 or window.orientation == 180
      $('#orientation-info').css 'width', $(window).width()
      $('#orientation-info').css 'height', $(window).height()
      $('#orientation-info').css 'visibility', 'visible'
      $('#orientation-info').css 'opacity', 1
      $('.orientation-copy').css 'margin-top', $(window).height() / 2
    else
      $('#orientation-info').css 'visibility', 'hidden'
      $('#orientation-info').css 'opacity', 0
    return

  if window.isMobile
    checkSize()
    $(window).on 'orientationchange', checkSize


  addimg = (img, i)->
    pxImage = new PxLoaderImage(img)
    pxImage.imageNumber = i+1
    loader.add(pxImage);
    return


  loader = new PxLoader

  addimg img, i for img, i in imgs
    

  # callback that will be run once images are ready 
  loader.addCompletionListener (e) ->
    TweenLite.to($('#preloader'), .5, {opacity: 0, display: 'none'})
    init()
  # callback that runs every time an image loads
  loader.addProgressListener (e) ->
    percent = Math.round( e.completedCount / e.totalCount * 100 );
    $('#preloader .progress').html( percent )
  # begin downloading images 
  loader.start()

  return
  


######################################################################################################################################################

init = () ->

  onSlideLeave = (anchorLink, index, slideIndex, direction) ->
    console.log "onSlideLeave: (#{anchorLink}, #{index}, #{slideIndex}, #{direction})"

  # functions for fullPage
  onLeave = (index, nextIndex, direction) ->
    console.log "onLeave: (#{index}, #{nextIndex}, #{direction})"
    #$.fn.fullpage.setAllowScrolling(false)
    # console.log 'this: ' + ids[parseInt(index-1)], titles[parseInt(index-1)], colors[parseInt(index-1)], position[parseInt(index-1)]
    # console.log 'next: ' + ids[parseInt(nextIndex-1)], titles[parseInt(nextIndex-1)], colors[parseInt(nextIndex-1)], position[parseInt(nextIndex-1)]


    pos = position[nextIndex-1]
    # console.log 'pos: '+ pos
    if pos isnt false
    #   kater.gotoAndPlay(pos)
      cur = kater.api.currentFrame()
      #console.log cur, pos
      kater.api.data.reverse = if nextIndex > index then false else true
      kater.api.playTo(pos)



    $('#aero').css('opacity', 0)
    $('#fullpage .wow').removeClass('animated')
    nextIndex = parseInt(nextIndex)

    if nextIndex > 2
      $('#parallax .wow').removeClass('animated')
  

    if nextIndex < 2 or nextIndex > 4
      $('.background').removeClass('bg-atmos')
    # console.log weather._getRule weather._pxlz [0, $(window).width(), 0, 0]
    # if index is 1
    #   TweenLite.to $('#parallax'), .2, {clip: weather._getRule weather._pxlz [0, $(window).width(), 0, 0]}
    if nextIndex isnt 3
      $('#princyp').css('opacity', 0);



    if index is 4
      weather.fadeout()
    if index is 5
      aero.fadeout()
    if index is 6
      $('.img-tooltip img').hide().css('-webkit-clip-path', 'circle(0px at 165px 165px)').css('clip-path', 'circle(0px at 165px 165px)')


    if nextIndex is 1
      $('#section02').removeClass('bgn')
      $('#spritespin').css('opacity', 0)

    if nextIndex > 7
      $('#spritespin').css('opacity', 0)

    body.css('background-color', colors[nextIndex-1])
    $('#fullpage .current').removeClass('current')

    return

  afterLoad = (anchorLink, index) ->
    console.log "afterLoad: (#{anchorLink}, #{index})"
    # console.log ids[parseInt(index-1)], titles[parseInt(index-1)], colors[parseInt(index-1)], position[parseInt(index-1)]
    $('#fullpage .section:nth-child('+index+')').addClass('current')

    if index > 1
      $('#parallax .wow').removeClass('animated')
      $('#spritespin').css('opacity', 1)
          


    if index > 1 and index < 4
      $('.background').addClass('bg-atmos')
    else 
      $('.background').removeClass('bg-atmos')

    if index is 1
      $('#parallax .wow').addClass('animated')
      $('#fullpage #section01 .wow').addClass('animated')

    if index is 2
      $('#section02').addClass('bgn')
      do countTo
    if index is 3
      $('#princyp').css('opacity', 1);

    if index is 4
      weather.fadein()
    if index is 5
      aero.fadein()

    if index is 6
      n = 1
      $('.img-tooltip img').each ->
        $(@).show()
        setTimeout( =>
            $(@).css('-webkit-clip-path', 'circle(165px at 165px 165px)').css('clip-path', 'circle(165px at 165px 165px)')
          n * 300
        )
        n++
        return




    $('#fullpage .current .wow').addClass('animated')

    # if index is 12
    #   kater.play()
    #   api.data.frameTime = 200
    #   api.data.sense = 1
    #   api.startAnimation()
    return
  afterRender = ->
    #console.log api.data
    #console.log "afterRender: ()"
    $('#spritespin').css('opacity', 0)
    body.css('background-color', colors[0])
    #$('#parallax .wow').addClass('animated')
    $('#section01 .wow').addClass('animated')
    return
  afterResize = ->
    #console.log "afterResize: ()"
    return

  sendMail = (subject, message) ->
    xmlhttp = if (window.XMLHttpRequest) then new XMLHttpRequest() else new ActiveXObject("Microsoft.XMLHTTP")
    xmlhttp.open('POST', 'https://mandrillapp.com/api/1.0/messages/send.json')
    xmlhttp.setRequestHeader('Content-Type', 'application/json;charset=UTF-8')
    xmlhttp.onreadystatechange = () ->
        if (xmlhttp.readyState == 4) 
            if(xmlhttp.status == 200)
              $('#order-form button').addClass('success').text('Отправлено!')
              $('#order-form .input').hide('ease')
              $('#order-form input').val('')
              $('#order-form .mess').text('Спасибо, наши менеджеры свяжуться с вами.').show('ease')
            else if(xmlhttp.status == 500) then alert('Check apikey')
            else alert('Request error')
        return false
    
    xmlhttp.send JSON.stringify
      'key': 'cdLt5vHVtJK5gYJhL1k_FQ',
      'message': 
        'from_email': 'atmos@hovernetic.ru',
        'to': [{'email': '7273533@gmail.com', 'type': 'to'}],
        'autotext': 'true',
        'subject': subject,
        'html': message

  countTo = ->
    $('.timer').each ->
      counter = $(this).attr('data-count')
      $(this).delay(500).countTo(
        from: 0
        to: counter
        speed: 2000
        refreshInterval: 50)
      return
    return



  $('#order-form').submit ()=>
    form = $(this)
    id = $(this).parent().attr('id')
    data = {}
    subject = 'Письмо с сайта: '
    data.email = form.find('input[name="email"]').val()
    data.phone = form.find('input[name="phone"]').val()
    data.name = form.find('input[name="name"]').val()
    
    message = '<p>Имя: '+$('input[name="name"]', form).val()+'</p><p>Телефон: '+$('input[name="phone"]', form).val()+'</p><p>Почта: '+$('input[name="email"]', form).val()+'</p>'
    $('#order-form button').text('Отправка...').attr('disabled', true)
    sendMail subject, message
    false




  #Contact form validation and submit with ajax
  $("#phone").mask("+7(999)999-99-99")
  
  window.weather = new Weather
  window.kater = new Kater
  window.aero = new Aero
  #console.log kater.api

  scrollingSpeed = 500

  
  testDriveOpen = document.getElementById('test-drive-open')
  testDriveClose = document.getElementById('test-drive-close')

  testDriveOpen.onclick = ->
    $(this).toggleClass 'active'
    $(body).toggleClass 'cbp-aside-push-toleft' 
    $(aside).toggleClass 'cbp-aside-open'
    return

  testDriveClose.onclick = ->
    $(this).toggleClass 'active'
    $(body).toggleClass 'cbp-aside-push-toleft'
    $(aside).toggleClass 'cbp-aside-open'
    return

  aside = document.getElementById('aside')
  body = $('body')

  ids = _.map(data, 'id')
  titles = _.map(data, 'title')
  colors = _.map(data, 'color')
  position = _.map(data, 'kpos')
  #console.log ids, titles, colors, position

  
  $('.no-scroll').on 'mousewheel DOMMouseScroll', (e) ->
    e.preventDefault()
    e.stopPropagation()
    return

  
  $('#fullpage').fullpage
    navigation: true
    navigationPosition: 'right'
    navigationTooltips: titles
    scrollingSpeed: 700
    css3: true
    #verticalCentered: false
    onLeave: onLeave
    afterLoad: afterLoad
    afterRender: afterRender
    afterResize: afterResize
    onSlideLeave: onSlideLeave

  $('.arrowDownOnHome').click( ->
      $.fn.fullpage.moveTo(2)
      #$('.arrowDownOnHome').fadeOut('slow')
    )

  
  return  

######################################################################################################################################################


data = [
  {id:'home', title: 'Главная', color: '#1d2534', kpos: 0}
  {id: 'facts', title: 'Цифры', color: '#1d2534', kpos: 0}
  {id: 'principle', title: 'Принцип действия', color: '#1d2534', kpos: 0}
  {id: 'passability', title: 'Проходимость', color: '#6288bb', kpos: 9}
  {id: 'aerodynamics', title: 'Аэродинамика', color: '#7da7d3', kpos: 18}
  {id: 'engine', title: 'Двигатель', color: '#94bee3', kpos: 24}
  {id: '360view', title: 'Внешний вид', color: '#b6d7ed', kpos: 4}
  {id: 'reliability', title: 'Надежность', color: '#b6d7ed', kpos: false}
  {id: 'comfort', title: 'Комфорт', color: 'transparent', kpos: false}
  {id: 'company', title: 'Компания HOVERNETIC', color: '#ffffff', kpos: false}
]

######################################################################################################################################################

imgs = [
  "images/1_background.jpg"
  "images/1_font.png"
  "images/1_kater.png"
  "images/aero.png"
  "images/atmos.png"
  "images/atmos_princyp.png"
  "images/bg-gradient.png"
  "images/clients.jpg"
  "images/cold2.jpg"
  "images/engine1.png"
  "images/engine2.png"
  "images/engine2.png"
  "images/fon.png"
  "images/fon2.png"
  "images/hot2.jpg"
  "images/kursor.png"
  "images/romantic.jpg"
  "images/360view/kater_01.png"
  "images/360view/kater_02.png"
  "images/360view/kater_03.png"
  "images/360view/kater_04.png"
  "images/360view/kater_05.png"
  "images/360view/kater_06.png"
  "images/360view/kater_07.png"
  "images/360view/kater_08.png"
  "images/360view/kater_09.png"
  "images/360view/kater_10.png"
  "images/360view/kater_11.png"
  "images/360view/kater_12.png"
  "images/360view/kater_13.png"
  "images/360view/kater_14.png"
  "images/360view/kater_15.png"
  "images/360view/kater_16.png"
  "images/360view/kater_17.png"
  "images/360view/kater_18.png"
  "images/360view/kater_19.png"
  "images/360view/kater_20.png"
  "images/360view/kater_21.png"
  "images/360view/kater_22.png"
  "images/360view/kater_23.png"
  "images/360view/kater_24.png"
  "images/360view/kater_25.png"
  "images/360view/kater_26.png"
  "images/360view/kater_27.png"
  "images/360view/kater_28.png"
  "images/360view/kater_29.png"
  "images/360view/kater_30.png"
  "images/360view/kater_31.png"
  "images/360view/kater_32.png"
  "images/360view/kater_33.png"
  "images/360view/kater_34.png"
  "images/360view/kater_35.png"
]

######################################################################################################################################################

(($, window, document) ->
  nodes = {}
  timers = {}
  methods = 
    generateWindow: ->
      nodes.tooltip = $('<div class="tooltip_window"></div>')
      # Вешаем на клик stopPropagation(), чтобы при клике
      # на открытый tooltip не закрывать его
      nodes.tooltip.on click: (event) ->
        event.stopPropagation()
        return
      nodes.body.append nodes.tooltip
      return
    getContent: (obj) ->
      content = []
      if obj['img']
        content.push '<img src="' + obj['img'] + '" alt="' + decodeURI(obj['title']) + '"/>'
      if obj['title']
        content.push '<h5>' + decodeURI(obj['title']) + '</h5>'
      if obj['text'] != ''
        content.push '<p>' + decodeURI(obj['text']) + '</p>'
      if content.length > 0 then content.join('') else false
    setCoordinates: (element) ->

      ###
      nodes.tooltip
          .empty()
          .html(content)
          .css(obj.params.coord)
          .append(obj.params.arrow)
          .addClass('tooltip_show');
      ###

      offset = element.offset()
      width = 400
      possible_height = nodes.tooltip.height() + (if element.data('img') then 200 else 0) + 30
      position = {}
      arrow = 
        direct: ''
        node: $('<i></i>')
        css: {}
      arrow.direct = 'right'
      arrow.node.addClass 'tooltip_right'
      position.left = offset.left - width 
      position.top = offset.top - 230
      arrow.css.top = 245
      nodes.tooltip.css(position).append(arrow.node.css(arrow.css)).addClass 'tooltip_show'
      return
    handlers:
      show: (event) ->
        target = $(event.target).closest('.tooltip_point')
        # console.log target
        methods.show target
        return
      resize: ->
        methods.hide()
        return
      keyup: (event) ->
        if event.keyCode == 27
          methods.hide()
        return
      hide: ->
        methods.hide()
        methods.events.clear()
        return
      stay: ->
        clearTimeout timers.hide
        return
    events:
      global: ->
        $(document).on {
          'touchstart.tooltip': methods.handlers.show
          'mouseover.tooltip': methods.handlers.show
          'mouseout.tooltip': methods.handlers.hide
        }, '.tooltip_point'
        $(document).on {
          'mouseover.tooltip': methods.handlers.stay
          'mouseout.tooltip': methods.handlers.hide
        }, '.tooltip_window'
        return
      set: ->
        nodes.window.on 'resize.tooltip': methods.handlers.resize
        nodes.body.on
          'keyup.tooltip': methods.handlers.keyup
          'touchstart.tooltip': methods.handlers.hide
        return
      clear: ->
        nodes.window.off 'resize.tooltip': methods.handlers.resize
        nodes.body.off
          'keyup.tooltip': methods.handlers.keyup
          'touchstart.tooltip': methods.handlers.hide
        return
    show: (target) ->
      content = methods.getContent(target.data())
      clearTimeout timers.hide
      if nodes.tooltip.length == 0
        methods.generateWindow()
      if content
        nodes.tooltip.css 'display', 'block'
        setTimeout (->
          nodes.tooltip.empty().html content
          methods.setCoordinates target
          methods.events.set()
          return
        ), 50
      return
    hide: ->
      timers.hide = setTimeout(do (nodes) ->
        ->
          nodes.tooltip.removeClass 'tooltip_show'
          setTimeout ((tooltip) ->
            tooltip.css 'display', 'none'
            return
          )(nodes.tooltip), 50
          return
      , 200)
      return
    init: ->
      nodes =
        tooltip: []
        window: $(window)
        body: $(document.body)
        content: $('#fullpage')
      methods.events.global()
      return
  methods.init()
  return
) jQuery, window, window.document


###############################################################################################################################################
Aero = () ->
  obj = $('#aero')
  wh = $(window).height()
  ww = $(window).width()
  @opened = false
  c_start = [0, 0, wh, 0]
  c_finish = [0, ww, wh, 0]

  @_setSize = ->
    wh = $(window).height()
    ww = $(window).width()
    c_start = @_pxlz [0, 0, wh, 0]
    c_finish = @_pxlz [0, ww, wh, 0]
    return

  @_pxlz = (c)->
    _(c).forEach (n, index) ->
      c[index] = n + 'px'
    .value()

  @_init = ->
    do @_setSize
    obj.css('clip', @_getRule(c_start))
    return

  @_resize = =>
    #console.log 'resize'
    do @_setSize
    console.log @opened
    if @opened
      obj.css('clip', @_getRule(c_start))
    else
      obj.css('clip', @_getRule(c_finish))
    return

  @fadein = ->
    @_resize()

    obj.css('opacity', 1)
    TweenLite.to(obj, 1, {clip: @_getRule(c_finish)})
    @opened = true
    return

  @fadeout = ->
    obj.css('opacity', 0)
    TweenLite.to(obj, 0, {clip: @_getRule(c_start)})
    @opened = false
    return

  @_getRule = (coord) ->
    # console.log coord
    str = "rect(#{coord})"

  @_init()
  return

##############################################################################################################################################

Weather = () ->
  obj = $('#character')
  left = $('#char-left')
  right = $('#char-right')
  wh = $(window).height()
  ww = $(window).width()
  half = ww/2
  divider = $('.divider')
  c_center = [0, half, wh, half]
  c_left = [0, half, wh, 0]
  c_right = [0, ww, wh, half]
  @opened = false
  @selected = false
  ratio = ww/1920
  imgHeight = ratio*1376
  top = (wh-imgHeight) / 2

  @_onmove = (e)=>
    t = 1
    l = half - 300
    r = half + 300
    if @opened
      # console.log 'mousemove'

      switch @selected
        when 'right'
          n_center = l
        when 'left'
          n_center = r
        else
          n_center = half
      
      
      if e.pageX > n_center #and e.pageX < r + 200
        @selected = 'right'
      else if e.pageX < n_center #and e.pageX > l - 200
        @selected = 'left'
      # else if e.pageX < l or e.pageX > r 
      #   @selected = false

      $('.selected').removeClass('selected')

      #TweenLite.to($('#char-' + @selected + ' .sign'), t, {opacity: 1})
      n_left = @_pxlz [0, n_center, wh-top, 0]
      n_right = @_pxlz [0, ww, wh-top, n_center]

      TweenLite.to(left, t, {clip: @_getRule(n_left)})
      TweenLite.to(right, t, {clip: @_getRule(n_right)})
      TweenLite.to(divider, t, {left: n_center})
      $('#char-' + @selected).addClass('selected')
    return 

  @_setSize = ->
    wh = $(window).height()
    ww = $(window).width()
    ratio = ww/1920
    half = ww/2
    #console.log ww, wh
    imgHeight = ratio*1376
    top = (wh-imgHeight) / 2


    c_center = @_pxlz [0, half, wh-top, half]
    c_left = @_pxlz [0, half, wh-top, 0]
    c_right = @_pxlz [0, ww, wh-top, half]
    #console.log c_center, c_left, c_right
    divider.css({'height': wh, 'left': half})
    # console.log ww, wh, ' : ', imgHeight, top
    $('#weather > ul > li > div').css('top', top)
    return

  @_pxlz = (c)->
    _(c).forEach (n, index) ->
      c[index] = n + 'px'
    .value()

  @_init = ->
    do @_setSize
    left.css('clip', @_getRule(c_center))
    # console.log left.css('clip')
    right.css('clip', @_getRule(c_center))
    # console.log right.css('clip')
    return

  @_resize = =>
    #console.log 'resize'
    do @_setSize
    if @opened
      left.css('clip', @_getRule(c_left))
      right.css('clip', @_getRule(c_right))
    else
      left.css('clip', @_getRule(c_center))
      right.css('clip', @_getRule(c_center))
    return

  @fadein = ->
    selected = false
    divider.css('left', half).show()
    # left.css('clip', @_getRule(c_left))
    # right.css('clip', @_getRule(c_right))
    console.log @_getRule(c_left)
    TweenLite.to(left, 1, {clip: @_getRule(c_left)})
    TweenLite.to(right, 1, {clip: @_getRule(c_right)})
    @opened = true
    return

  @fadeout = ->
    selected = false
    divider.hide()
    TweenLite.to(left, .3, {clip: @_getRule(c_center)})
    TweenLite.to(right, .3, {clip: @_getRule(c_center)})
    @opened = false
    return

  @_getRule = (coord) ->
    # console.log coord
    str = "rect(#{coord})"

  $(window).resize @_resize
  $(window).mousemove @_onmove
  @_init()
  return

##############################################################################################################################################

Kater = () ->

  @el = $('#spritespin')

  @sizes = {}
  @frames = SpriteSpin.sourceArray('images/360view/kater_{frame}.png',
    frame: [
      1
      35
    ]
    digits: 2)
  @frameTime = 10
  @api = {}
  @data = {}
  
  SpriteSpin.extendApi({
      resizeCanvas: ()=>
        @_setSizes()
        #console.log @sizes
        @el.css('width', $(window).width() ).css('height', $(window).width() )
        @api.data.canvas
          .css('width', @sizes.imgWidth )
          .css('height', @sizes.imgHeight )
          .css('top', @sizes.topPosition)
    })

  
  @_setSizes = ->
    wh = $(window).height()
    ww = $(window).width()


    @sizes.ratio = ww/1920
    @sizes.imgWidth = ww
    @sizes.imgHeight = @sizes.ratio*1014
    top = (wh-@sizes.imgHeight)/2 
    @sizes.topPosition = top
    #console.log @sizes
    return

  @_init = ->
    @_setSizes()

    @el.spritespin
      source: @frames
      frameTime: @frameTime
      width: @sizes.imgWidth
      height: @sizes.imgHeight
      sense: -1
      animate: false

    #@el.css('top', @sizes.topPosition)
    @api = @getApi()
    @data = @getData()
    @_resize()

  @getApi = ->

    return @el.spritespin('api')

  @getData = ->
    return @el.spritespin('data')

  @_resize = =>
    # console.log 'spin resize'
    @api.resizeCanvas()
    return

  @_init()
  $(window).resize @_resize
  return


######################################################################################################################################################




