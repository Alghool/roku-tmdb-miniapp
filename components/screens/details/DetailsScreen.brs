sub Init()
  
  'observer for screen visibility
  m.top.observeField("visible", "onVisibleChange")
  
  m.heroBanner = m.top.findNode("heroBanner")
  m.titleText = m.top.findNode("title")
  m.descriptionText = m.top.findNode("description")
  m.descriptionText.observeField("isTextEllipsized", "onDscriptionEllipsisChanged")
  m.moreBtn = m.top.findNode("moreBtn")
  m.moreBtn.observeField("buttonSelected", "onButtonSelected")
end sub

sub onVisibleChange()
  if m.top.visible
     m.moreBtn.setFocus(true)
  end if
end sub

sub onSelectedContent()
  content = m.top.selectedContent
  if content <> invalid
    m.heroBanner.uri = content.herobannerurl
    m.titleText.text = content.title
    m.descriptionText.text = content.description
    m.descriptionText.numLines = 2
    m.moreBtn.text = "Read More"
    m.moreBtn.visible = m.descriptionText.isTextEllipsized  
  end if
end sub

sub onDscriptionEllipsisChanged()
  if  m.descriptionText.numLines = 2 AND m.descriptionText.isTextEllipsized
    m.moreBtn.text = "Read More"
    m.moreBtn.visible = true 
  else if m.descriptionText.numLines = 0
    m.moreBtn.text = "Read Less"
    m.moreBtn.visible = true 
  else
    m.moreBtn.visible = false 
  end if
end sub

sub onButtonSelected()
  if m.descriptionText.numLines = 2 
    m.descriptionText.numLines = 0
  else 
    m.descriptionText.numLines = 2
  endif
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  if press then
    ? "btn: " + key + " is pressed" 
    if key = "back" then
      m.top.getScene().detailsContent = invalid
      return true
    end if
  end if
end function