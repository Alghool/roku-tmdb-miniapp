sub Init()
  m.Poster = m.top.findNode("poster")
  m.Title = m.top.findNode("title")
end sub

sub itemContentChanged()
  content = m.top.itemContent

  m.title.text = content.title
  
  if content.row = "Now PLaying"
    m.poster.uri = content.herobannerurl
    m.poster.width = 476
    m.poster.height = 273
    
    m.title.width = 476
    m.title.height = 273

  else
    m.poster.uri = content.hdposterurl
  end if


end sub