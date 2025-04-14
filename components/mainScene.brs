sub init()
    m.top.setFocus(true)
    m.LandingScreen = m.top.FindNode("LandingScreen")
    m.DetailsScreen = m.top.FindNode("DetailsScreen")
    showLandingScreen()
end sub

sub OnAppLaunchCompleted() 
    m.top.signalBeacon("AppLaunchComplete")
end sub

sub OnDetailsContentSelected()
    m.top.setFocus(true)
    content = m.top.detailsContent
    if content <> invalid
        showDetailsScreen()
    else
        showLandingScreen()
    end if
endsub

sub showLandingScreen()
    m.LandingScreen.visible = true
    m.detailsscreen.visible = false
    m.LandingScreen.setFocus(true) 
end sub

sub showDetailsScreen()
    m.LandingScreen.visible = false
    m.detailsscreen.visible = true
    m.DetailsScreen.setFocus(true)
end sub