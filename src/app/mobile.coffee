
$(document).ready ->



  $("#phone").mask("+7(999)999-99-99")


  window.kater = new Kater

  
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


  $('#order-form').submit () ->
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

##############################################################################################################################################

Kater = () ->

  @el = $('#spritespin')

  @sizes = {}
  @frames = SpriteSpin.sourceArray('images/mobile/360view/kater_{frame}.png',
    frame: [
      1
      35
    ]
    digits: 2)
  @frameTime = 50
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
        $('#spritespin').css('height', @sizes.imgHeight )
        $('.spritespin-canvas').css('top', 0)

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
    console.log 'spin resize'
    @api.resizeCanvas()
    return

  @_init()
  $(window).resize @_resize
  return

