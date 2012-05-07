# Get DOM references.
hitchslider             = $( "#hitchslider" )
hitchslider_nextNav     = $( "#hitchslider_nextNav" )
hitchslider_prevNav     = $( "#hitchslider_prevNav" )
hitchslider_map         = $( "#hitchslider_map" )
hitchslider_caption     = $( "#hitchslider_caption" )
hitchslider_information = $( "#hitchslider_information" )


window.Hitchslider =
  show_information: ->
    $( "#hitchslider_information" ).animate(
      { left: 0 },
      {
        duration: 150, 
        # When complete, flag all animations as being done.
        complete: ->
          console.log 'complete show_information'
      })
  hide_information: ->
    $( "#hitchslider_information" ).animate( { left: '-200px'},
      {
        duration: 150, 
        # When complete, flag all animations as being done.
        complete: ->
          console.log 'complete hide_information'
      })


# Mouse over handler:
#$( [] ).add( hitchslider ).add( hitchslider_information ).add( hitchslider_nextNav ).add( hitchslider_caption ).add( hitchslider_prevNav ).mouseover ->
  #return( false )

#$( [] ).add( hitchslider ).add( hitchslider_information ).add( hitchslider_nextNav ).add( hitchslider_caption ).add( hitchslider_prevNav ).mouseover ->
  #return( false )
