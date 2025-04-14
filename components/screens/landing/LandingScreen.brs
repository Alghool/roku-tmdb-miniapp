sub Init()
  m.loadCount = 0 
  'observer for screen visibility
  m.top.observeField("visible", "onVisibleChange")
  'rails or carousels of movies
  m.rowList = m.top.findNode("RowList")
  m.rowListData = {}
  'background poster of hero part
  m.heroBanner = m.top.findNode("heroBanner")
  'loading to let know user the channel is retrieving the content
  m.loadingText = m.top.findNode("loading")
  'repositioning of loading text to center of the screen
  m.loadingText.translation = [(1920 - m.loadingText.boundingRect().width) / 2, (1080 - m.loadingText.boundingRect().height) / 2]

  m.titleText = m.top.findNode("title")

  m.descriptionText = m.top.findNode("description")
  'shows loading text
  showLoading()
  'fetching data in parallel to save run time
  fetchNowPlayingMovies()
  fetchPopularMovies() 
end sub

sub onVisibleChange()
  if m.top.visible
    m.rowList.setFocus(true)
  end if
end sub

sub showLoading()
  m.loadingText.visible = true
end sub

sub hideLoading()
  m.loadingText.visible = false
end sub

sub fetchNowPlayingMovies()

  ' separate task for API request
  requestTask = CreateObject("roSGNode", "RequestTask")
  requestTask.status = "None"
  requestTask.type = "get"
  requestTask.url = "https://api.themoviedb.org/3/movie/now_playing"
  requestTask.observeField("status", "onNowPlayingFetched")
  requestTask.control = "RUN"
end sub

function onNowPlayingFetched(event as object)
  if event.getData() = "Success"
    items = getPopularMoviesData(event.getRoSGNode().data) 
    m.rowListData.nowPlaying = items

    m.loadCount++
    if m.loadCount = 2
      showGrid()
    end if  
  else
    m.loadingText.text = "faild to load data please try again later, thank you"
  end if

end function

sub fetchPopularMovies()
    'separate task for API request
    requestTask = CreateObject("roSGNode", "RequestTask")
    requestTask.status = "None"
    requestTask.type = "get"
                      'https://api.themoviedb.org/3/movie/popular
    requestTask.url = "https://api.themoviedb.org/3/movie/popular"
    requestTask.observeField("status", "onPopularFetched")
    requestTask.control = "RUN"
end sub

function onPopularFetched(event as object)

  if event.getData() = "Success"
    data = event.getRoSGNode().data
 
    items = getPopularMoviesData(event.getRoSGNode().data) 
    m.rowListData.popular = items

    m.loadCount++
    if m.loadCount = 2
      showGrid()
    end if
  else
    m.loadingText.text = "faild to load data please try again later, thank you"
  end if
end function

sub showGrid()
  'both loading are done
  hideLoading()
  data = CreateObject("roSGNode", "ContentNode")
  data = createRow(data, m.rowListData.nowPlaying, "Now PLaying" )
  data = createRow(data, m.rowListData.popular, "Popular" )
  m.top.content = data
end sub

sub onItemFocused(message as Object)
  selectedIndex = m.top.itemFocused
  m.top.focusedContent = m.top.content.getChild(selectedIndex[0]).getChild(selectedIndex[1])
end sub

sub updateHeroContent()
  selectedItem = m.top.focusedContent
  m.heroBanner.uri = selectedItem.herobannerurl
  m.titleText.text = selectedItem.title
  m.descriptionText.text = selectedItem.description
end sub

sub onSelectedContent()
  selectedIndex = m.top.selectedContent
  selectedContent = m.top.content.getChild(selectedIndex[0]).getChild(selectedIndex[1])
  m.top.getscene().detailsContent = selectedContent
end sub