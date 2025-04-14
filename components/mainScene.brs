sub init()
    m.top.setFocus(true)
    m.LandingScreen = m.top.FindNode("LandingScreen")
    m.DetailsScreen = m.top.FindNode("DetailsScreen")
    ' ahow landing screen for content selection
    showLandingScreen()
end sub

sub OnAppLaunchCompleted() 
    m.top.signalBeacon("AppLaunchComplete")
end sub

sub OnDetailsContentSelected()
    'handle screen navigation
    m.top.setFocus(true)
    content = m.top.detailsContent
    if content <> invalid
        showDetailsScreen()
    else
        showLandingScreen()
    end if
endsub

sub showLandingScreen()
    'show landing page
    m.LandingScreen.visible = true
    m.Detailsscreen.visible = false
    m.LandingScreen.setFocus(true) 
end sub

sub showDetailsScreen()
    'show details page
    m.LandingScreen.visible = false
    m.Detailsscreen.visible = true
    m.DetailsScreen.setFocus(true)
end sub