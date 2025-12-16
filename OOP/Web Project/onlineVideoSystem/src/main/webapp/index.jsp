<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vidoora</title>
  <link rel="stylesheet" href="css/bootstrap.min.css" />
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
  <!-- i will provide this in description  -->
  <link rel="stylesheet" href="css/slick.css" />
  <link rel="stylesheet" href="css/slick-theme.css" />
  <link rel="stylesheet" href="css/owl.carousel.min.css" />
  <link rel="stylesheet" href="css/animate.min.css" />
  <link rel="stylesheet" href="css/magnific-popup.css" />
  <link rel="stylesheet" href="css/select2.min.css" />
  <link rel="stylesheet" href="css/select2-bootstrap4.min.css" />

  <link rel="stylesheet" href="css/slick-animation.css" />
  <link rel="stylesheet" href="css/HomeCss.css" />

  <style>/* From Uiverse.io by abrahamcalsin */ 
button {
  position: relative;
  width:150px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
  background: #ff0101;
  font-family: "Roboto", sans-serif;
  box-shadow: 0px 6px 24px 0px rgba(0, 0, 0, 0.2);
  overflow: hidden;
  cursor: pointer;
  border: none;
}

button:after {
  content: " ";
  width: 0%;
  height: 100%;
  background: #183153;
  position: absolute;
  transition: all 0.4s ease-in-out;
  right: 0;
}

button:hover::after {
  right: auto;
  left: 0;
  width: 100%;
}

button span {
  text-align: center;
  text-decoration: none;
  width: 100%;
  padding: 18px 25px;
  color: #fff;
  font-size: 0.75em;
  font-weight: 700;
  letter-spacing: 0.2em;
  z-index: 20;
  transition: all 0.3s ease-in-out;
}

button:hover span {
  color: #ffffff;
  animation: scaleUp 0.3s ease-in-out;
}

@keyframes scaleUp {
  0% {
    transform: scale(1);
  }

  50% {
    transform: scale(0.95);
  }

  100% {
    transform: scale(1);
  }
}
</style>
</head>

<body>

<!--Header start-->
  <header id="main-header">
    <div class="main-header">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12">
            <nav class="navbar navbar-expand-lg navbar-light p-0">
              <a href="#" class="navbar-toggler c-toggler" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <div class="navbar-toggler-icon" data-toggle="collapse">
                  <span class="navbar-menu-icon navbar-menu-icon--top"></span>
                  <span class="navbar-menu-icon navbar-menu-icon--middle"></span>
                  <span class="navbar-menu-icon navbar-menu-icon--bottom"></span>
                </div>
              </a>
              <a href="index.jsp" class="navbar-brand">
                <img src="images/Newlogo.png" class="img-fluid logo" alt="" />
              </a>
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <div class="menu-main-menu-container">
                  <ul id="top-menu" class="navbar-nav ml-auto">
                    <li class="menu-item"><a href="#">Home</a></li>
                    <li class="menu-item"><a href="${pageContext.request.contextPath}/VideoListServlet">Movies</a></li>
                    
                    <li class="menu-item">
                      <a href="#">Contact Us</a>
                      <ul class="sub-menu">
                        <li class="menu-item"><a href="AboutUs.jsp">About Us</a></li>
                        <li class="menu-item"><a href="contact.jsp">Contact</a></li>
                        <li class="menu-item"><a href="faq.jsp">FAQ</a></li>
                        <li class="menu-item">
                          <a href="privacyAndPolicy.jsp">Privacy-Policy</a>
                        </li>
                        <li class="menu-item">
                          <a href="pricing.jsp">Pricing</a>
                      
                        </li>
                      </ul>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="mobile-more-menu">
                <a href="javascript:void(0);" class="more-toggle" id="dropdownMenuButton" data-toggle="more-toggle"
                  aria-haspopup="true" aria-expanded="false">
                  <i class="fa fa-ellipsis-h"></i>
                </a>
                <div class="more-menu" aria-labelledby="dropdownMenuButton">
                  <div class="navbar-right position-relative">
                    <ul class="d-flex align-items-center justify-content-end list-inline m-0">
                      <li>
                        <a href="#" class="search-toggle">
                          <i class="fa fa-search"></i>
                        </a>
                        <div class="search-box iq-search-bar">
                          <form action="#" class="searchbox">
                            <div class="form-group position-relative">
                              <input type="text" class="text search-input font-size-12"
                                placeholder="type here to search..." />
                              <i class="search-link fa fa-search"></i>
                            </div>
                          </form>
                        </div>
                      </li>
                      <li class="nav-item nav-icon">
                        <a href="#" class="search-toggle position-relative">
                          <i class="fa fa-bell"></i>
                          <span class="bg-danger dots"></span>
                        </a>
                        <div class="iq-sub-dropdown">
                          <div class="iq-card shadow-none m-0">
                            <div class="iq-card-body">
                              <a href="#" class="iq-sub-card">
                                <div class="media align-items-center">
                                  <img src="images/notify/thumb-1.jpg" alt="" class="img-fluid mr-3" />
                                  <div class="media-body">
                                    <h6 class="mb-0">Captain Marvel</h6>
                                    <small class="font-size-12">just now</small>
                                  </div>
                                </div>
                              </a>
                              <a href="#" class="iq-sub-card">
                                <div class="media align-items-center">
                                  <img src="images/notify/thumb-2.jpg" alt="" class="img-fluid mr-3" />
                                  <div class="media-body">
                                    <h6 class="mb-0">
                                      Dora and The Lost City of Gold
                                    </h6>
                                    <small class="font-size-12">25 mins ago</small>
                                  </div>
                                </div>
                              </a>
                              <a href="#" class="iq-sub-card">
                                <div class="media align-items-center">
                                  <img src="images/notify/thumb-3.jpg" alt="" class="img-fluid mr-3" />
                                  <div class="media-body">
                                    <h6 class="mb-0">Mulan</h6>
                                    <small class="font-size-12">1h 30 mins ago</small>
                                  </div>
                                </div>
                              </a>
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
					  <!--user profile-->
                        <a href="${pageContext.request.contextPath}/SignInServlet">
                          <button type="button" class="cancelbtn">Sign In</button>
                        </a>


                      <!--user profile end--> 
                      </li>
                    </ul>
                  </div>
                </div>
              </div>

              <div class="navbar-right menu-right">
                <ul class="d-flex align-items-center list-inline m-0">
                  <li class="nav-item nav-icon">
                    <a href="#" class="search-toggle device-search">
                      <i class="fa fa-search"></i>
                    </a>
                    <div class="search-box iq-search-bar d-search">
                      <form action="#" class="searchbox">
                        <div class="form-group position-relative">
                          <input type="text" class="text search-input font-size-12"
                            placeholder="type here to search..." />
                          <i class="search-link fa fa-search"></i>
                        </div>
                      </form>
                    </div>
                  </li>
                  <li class="nav-item nav-icon">
                    <a href="#" class="search-toggle" data-toggle="search-toggle">
                      <i class="fa fa-bell"></i>
                      <span class="bg-danger dots"></span>
                    </a>
                    <div class="iq-sub-dropdown">
                      <div class="iq-card shadow-none m-0">
                        <div class="iq-card-body">
                          <a href="#" class="iq-sub-card">
                            <div class="media align-items-center">
                              <img src="images/notify/thumb-1.jpg" alt="" class="img-fluid mr-3" />
                              <div class="media-body">
                                <h6 class="mb-0">Captain Marvel</h6>
                                <small class="font-size-12">just now</small>
                              </div>
                            </div>
                          </a>
                          <a href="#" class="iq-sub-card">
                            <div class="media align-items-center">
                              <img src="images/notify/thumb-2.jpg" alt="" class="img-fluid mr-3" />
                              <div class="media-body">
                                <h6 class="mb-0">
                                  Dora and The Lost City of Gold
                                </h6>
                                <small class="font-size-12">25 mins ago</small>
                              </div>
                            </div>
                          </a>
                          <a href="#" class="iq-sub-card">
                            <div class="media align-items-center">
                              <img src="images/notify/thumb-3.jpg" alt="" class="img-fluid mr-3" />
                              <div class="media-body">
                                <h6 class="mb-0">Mulan</h6>
                                <small class="font-size-12">1h 30 mins ago</small>
                              </div>
                            </div>
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li class="nav-item nav-icon">
<a href="${pageContext.request.contextPath}/SignInServlet"> 
  <button>
  
    <span>SIGN IN</span>
  </button>
</a>
                    
                  </li>
                </ul>
              </div>
            </nav>
            <div class="nav-overlay"></div>
          </div>
        </div>
      </div>
    </div>
  </header>
  
  <!--Header end-->

  <!--slider start-->
  <section id="home" class="iq-main-slider p-0">
    <div id="home-slider" class="slider m-0 p-0">
      <div class="slide slick-bg s-bg-1">
        <div class="container-fluid position-relative h-100">
          <div class="slider-inner h-100">
            <div class="row align-items-center h--100">
              <div class="col-xl-6 col-lg-12 col-md-12">
                <a href="javascript:void(0)">
                  <div class="channel-logo" data-animation-in="fadeInLeft" data-delay-in="0.5">
                  <!--image for vidoora-->
                  </div>
                </a>
                <h1  data-animation-in="fadeInLeft" style="font-size: 50px; font-family: Algerian;"
                  data-delay-in="0.6">
                  Avengers
                </h1>
                <div class="d-flex flex-wrap align-items-center fadeInLeft animated" data-animation-in="fadeInLeft"
                  style="opacity: 1">
                  <div class="slider-ratting d-flex align-items-center mr-4 mt-2 mt-md-3">
                    <ul
                      class="ratting-start p-0 m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star-half"></i></li>
                    </ul>
                    <span class="text-white ml-2">7.3(imbd)</span>
                  </div>
                  <div class="d-flex align-items-center mt-2 mt-md-3">
                    <span class="badge badge-secondary p-2">16+</span>
                    <span class="ml-3">2h 21min</span>
                  </div>
                </div>
                <p data-animation-in="fadeInUp">
                  When Tony Stark and Bruce Banner try to jump-start a dormant
                  peacekeeping program called Ultron, things go horribly wrong.
                  
                </p>
                <div class="trending-list" data-animation-in="fadeInUp" data-delay-in="1.2">
                  <div class="text-primary title starring">
                    Starring :
                    <span class="text-body">Robert Downey Jr., Chris Evans, Mark Ruffalo</span>
                  </div>
                  <div class="text-primary title genres">
                    Genres : <span class="text-body">Action</span>
                  </div>
                  <div class="text-primary title tag">
                    Tags :
                    <span class="text-body">Action, Adventure, Horror</span>
                  </div>
                </div>
                <div class="d-flex align-items-center r-mb-23 mt-4" data-animation-in="fadeInUp" data-delay-in="1.2">
                  <a href="video/avengers.mp4" class="btn btn-hover iq-button"><i class="fa fa-play mr-3"></i>Play Now</a>
                  <a href="https://www.marvel.com/teams-and-groups/avengers/on-screen" class="btn btn-link">More Details</a>
                </div>
              </div>
            </div>
            <div class="col-xl-5 col-lg-12 col-md-12 trailor-video">
              <a href="video/avengers.mp4" class="video-open playbtn">
                <img src="images/play.png" class="play" alt="" />
                <span class="w-trailor">Watch Trailer</span>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="slide slick-bg s-bg-2">
        <div class="container-fluid position-relative h-100">
          <div class="slider-inner h-100">
            <div class="row align-items-center h--100">
              <div class="col-xl-6 col-lg-12 col-md-12">
                <a href="javascript:void(0)">
                  <div class="channel-logo" data-animation-in="fadeInLeft" data-delay-in="0.5">
                    
                  </div>
                </a>
                <h1 style="font-size: 50px; font-family: Algerian;" data-animation-in="fadeInLeft"
                  data-delay-in="0.6">
                  Frozen
                </h1>
                <div class="d-flex flex-wrap align-items-center fadeInLeft animated" data-animation-in="fadeInLeft"
                  style="opacity: 1">
                  <div class="slider-ratting d-flex align-items-center mr-4 mt-2 mt-md-3">
                    <ul
                      class="ratting-start p-0 m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star-half"></i></li>
                    </ul>
                    <span class="text-white ml-2">7.4(imbd)</span>
                  </div>
                  <div class="d-flex align-items-center mt-2 mt-md-3">
                    <span class="badge badge-secondary p-2">13+</span>
                    <span class="ml-3">1h 42min</span>
                  </div>
                </div>
                <p data-animation-in="fadeInUp">
                  When the newly crowned Queen Elsa accidentally uses her
                  power to turn things into ice to curse her home in infinte
                  winter, her sister Anna teams up.
                  
                </p>
                <div class="trending-list" data-animation-in="fadeInUp" data-delay-in="1.2">
                  <div class="text-primary title starring">
                    Starring :
                    <span class="text-body">Kristan Bell, Idina menzel, Jonathan Groff</span>
                  </div>
                  <div class="text-primary title genres">
                    Genres : <span class="text-body">Animation</span>
                  </div>
                  <div class="text-primary title tag">
                    Tags :
                    <span class="text-body">Animation, Adventure, Comedy</span>
                  </div>
                </div>
                <div class="d-flex align-items-center r-mb-23 mt-4" data-animation-in="fadeInUp" data-delay-in="1.2">
                  <a href="video/frozen.mp4" class="btn btn-hover iq-button"><i class="fa fa-play mr-3"></i>Play Now</a>
                  <a href="https://frozen.disney.com/" class="btn btn-link">More Details</a>
                </div>
              </div>
            </div>
            <div class="col-xl-5 col-lg-12 col-md-12 trailor-video">
              <a href="video/frozen.mp4" class="video-open playbtn">
                <img src="images/play.png" class="play" alt="" />
                <span class="w-trailor">Watch Trailer</span>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="slide slick-bg s-bg-3">
        <div class="container-fluid position-relative h-100">
          <div class="slider-inner h-100">
            <div class="row align-items-center h--100">
              <div class="col-xl-6 col-lg-12 col-md-12">
                <a href="javascript:void(0)">
                  <div class="channel-logo" data-animation-in="fadeInLeft" data-delay-in="0.5">
                   
                  </div>
                </a>
                <h1 style="font-size: 50px; font-family: Algerian;" data-animation-in="fadeInLeft"
                  data-delay-in="0.6">
                  The Conjuring
                </h1>
                <div class="d-flex flex-wrap align-items-center fadeInLeft animated" data-animation-in="fadeInLeft"
                  style="opacity: 1">
                  <div class="slider-ratting d-flex align-items-center mr-4 mt-2 mt-md-3">
                    <ul
                      class="ratting-start p-0 m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star-half"></i></li>
                    </ul>
                    <span class="text-white ml-2">7.5(imbd)</span>
                  </div>
                  <div class="d-flex align-items-center mt-2 mt-md-3">
                    <span class="badge badge-secondary p-2">16+</span>
                    <span class="ml-3">1h 52min</span>
                  </div>
                </div>
                <p data-animation-in="fadeInUp">
                  Paranomal investigators Ed and Lorraine Warren work to help
                  a family terrorized by a dark presence in their farmhouse.
                </p>
                <div class="trending-list" data-animation-in="fadeInUp" data-delay-in="1.2">
                  <div class="text-primary title starring">
                    Starring :
                    <span class="text-body">Patrick Wilson, Vera Farminga, Ron Livingston</span>
                  </div>
                  <div class="text-primary title genres">
                    Genres : <span class="text-body">Horror</span>
                  </div>
                  <div class="text-primary title tag">
                    Tags :
                    <span class="text-body">Horror, Mystery, Thriller</span>
                  </div>
                </div>
                <div class="d-flex align-items-center r-mb-23 mt-4" data-animation-in="fadeInUp" data-delay-in="1.2">
                  <a href="video/conjuring.mp4" class="btn btn-hover iq-button"><i class="fa fa-play mr-3"></i>Play Now</a>
                  <a href="https://www.warnerbros.com/movies/conjuring#about" class="btn btn-link">More Details</a>
                </div>
              </div>
            </div>
            <div class="col-xl-5 col-lg-12 col-md-12 trailor-video">
              <a href="video/conjuring.mp4" class="video-open playbtn">
                <img src="images/play.png" class="play" alt="" />
                <span class="w-trailor">Watch Trailer</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!--slider end-->

  <!--main content start-->
  <div class="main-content">
    <!--favorite section start-->

    <section id="iq-favorites">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12 overflow-hidden">
            <div class="iq-main-header d-flex align-items-center justify-content-between">
              <h4 class="main-title">Top Picks For You</h4>
              
            </div>
            <div class="favorite-contens">
              <ul class="favorites-slider list-inline row p-0 mb-0">
                <!-- slide item 1 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/favorite/f1.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Insidious </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">16+</div>
                        <span class="text-white">1h 43min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/INSIDIOUS.mp4" class="btn btn-link"> Play Now </a>
                    
                        </span>
                      </div>
                    </div>
                  </div>
                </li>
                <!-- slide item 2 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/favorite/f2.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> War </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">12+</div>
                        <span class="text-white">2h 34min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/WAR.mp4" class="btn btn-link"> Play Now </a>
                         
                        </span>
                      </div>
                    </div>
           
                  </div>
                </li>
                <!-- slide item 3 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/favorite/f3.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Five Feet Apart </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">18+</div>
                        <span class="text-white">2h 57min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/FIVE FEET APART.mp4" class="btn btn-link"> Play Now </a>
                        
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 4 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/favorite/f4.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Chhichore </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">10+</div>
                        <span class="text-white">2h 23min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Chhichhore.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                  
                  </div>
                </li>
                <!-- slide item 5 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/favorite/f5.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Doctor Strange </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">12+</div>
                        <span class="text-white">1h 55min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Doctor_Strange.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!--favourite section end-->

  <!--popular contents section start-->
    <section id="iq-upcoming-movie">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12 overflow-hidden">
            <div class="iq-main-header d-flex align-items-center justify-content-between">
              <h4 class="main-title">Popular Movies</h4>
              <a href="#" class="iq-view-all">View All</a>
            </div>
            <div class="favorite-contens">
              <ul class="favorites-slider list-inline row p-0 mb-0">
                <!-- slide item 1 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/popular/u1.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a href="#"> Mulan </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">10+</div>
                        <span class="text-white">2h</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
                          Play Now
                        </span>
                      </div>
                    </div>
                    <div class="block-social-info">
                      <ul class="list-inline p-0 m-0 music-play-lists">
                        <li class="share">
                          <span><i class="fa fa-share-alt"></i></span>
                          <div class="share-box">
                            <div class="d-flex align-items-center">
                              <a href="#" class="share-ico"><i class="fa fa-share-alt"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-youtube"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-instagram"></i></a>
                            </div>
                          </div>
                        </li>
                        <li>
                          <span><i class="fa fa-heart"></i></span>
                          <span class="count-box">89+</span>
                        </li>
                        <li>
                          <span><i class="fa fa-plus"></i></span>
                        </li>
                      </ul>
                    </div>
                  </div>
                </li>
                <!-- slide item 2 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/popular/u2.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a href="#"> Laxmii </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">18+</div>
                        <span class="text-white">2h 21min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
                          Play Now
                        </span>
                      </div>
                    </div>
                    <div class="block-social-info">
                      <ul class="list-inline p-0 m-0 music-play-lists">
                        <li class="share">
                          <span><i class="fa fa-share-alt"></i></span>
                          <div class="share-box">
                            <div class="d-flex align-items-center">
                              <a href="#" class="share-ico"><i class="fa fa-share-alt"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-youtube"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-instagram"></i></a>
                            </div>
                          </div>
                        </li>
                        <li>
                          <span><i class="fa fa-heart"></i></span>
                          <span class="count-box">35+</span>
                        </li>
                        <li>
                          <span><i class="fa fa-plus"></i></span>
                        </li>
                      </ul>
                    </div>
                  </div>
                </li>
                <!-- slide item 3 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/popular/u3.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a href="#"> Captain America </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">12+</div>
                        <span class="text-white">2h 4min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
                          Play Now
                        </span>
                      </div>
                    </div>
                    <div class="block-social-info">
                      <ul class="list-inline p-0 m-0 music-play-lists">
                        <li class="share">
                          <span><i class="fa fa-share-alt"></i></span>
                          <div class="share-box">
                            <div class="d-flex align-items-center">
                              <a href="#" class="share-ico"><i class="fa fa-share-alt"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-youtube"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-instagram"></i></a>
                            </div>
                          </div>
                        </li>
                        <li>
                          <span><i class="fa fa-heart"></i></span>
                          <span class="count-box">99+</span>
                        </li>
                        <li>
                          <span><i class="fa fa-plus"></i></span>
                        </li>
                      </ul>
                    </div>
                  </div>
                </li>
                <!-- slide item 4 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/popular/u4.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a href="#"> Life of Pie </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">11+</div>
                        <span class="text-white">2h 7min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
                          Play Now
                        </span>
                      </div>
                    </div>
                    <div class="block-social-info">
                      <ul class="list-inline p-0 m-0 music-play-lists">
                        <li class="share">
                          <span><i class="fa fa-share-alt"></i></span>
                          <div class="share-box">
                            <div class="d-flex align-items-center">
                              <a href="#" class="share-ico"><i class="fa fa-share-alt"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-youtube"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-instagram"></i></a>
                            </div>
                          </div>
                        </li>
                        <li>
                          <span><i class="fa fa-heart"></i></span>
                          <span class="count-box">19+</span>
                        </li>
                        <li>
                          <span><i class="fa fa-plus"></i></span>
                        </li>
                      </ul>
                    </div>
                  </div>
                </li>
                <!-- slide item 5 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/popular/u5.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a href="#"> Mission Mangal </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">12+</div>
                        <span class="text-white">2h 10min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
                          Play Now
                        </span>
                      </div>
                    </div>
                    <div class="block-social-info">
                      <ul class="list-inline p-0 m-0 music-play-lists">
                        <li class="share">
                          <span><i class="fa fa-share-alt"></i></span>
                          <div class="share-box">
                            <div class="d-flex align-items-center">
                              <a href="#" class="share-ico"><i class="fa fa-share-alt"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-youtube"></i></a>
                              <a href="#" class="share-ico"><i class="fa fa-instagram"></i></a>
                            </div>
                          </div>
                        </li>
                        <li>
                          <span><i class="fa fa-heart"></i></span>
                          <span class="count-box">19+</span>
                        </li>
                        <li>
                          <span><i class="fa fa-plus"></i></span>
                        </li>
                      </ul>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!--popular contents section end-->

    <!--trending start-->

    <section id="iq-topten">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12 overflow-hidden">
            <div class="topten-contents">
              <h4 class="main-title iq-title topten-title">
                Trending Tv Shows
              </h4>
              <ul id="top-ten-slider" class="list-inline p-0 m-0 d-flex align-items-center">
                <li class="slick-bg">
                  <a href="#">
                    <img src="images/top-10/01.jpg" class="img-fluid w-100" alt="" />
                    <h6 class="iq-title"><a href="#">Harry Potter</a></h6>
                  </a>
                </li>
                <li class="slick-bg">
                  <a href="#">
                    <img src="images/top-10/02.jpg" class="img-fluid w-100" alt="" />
                    <h6 class="iq-title">
                      <a href="#">The Queen's Gambit</a>
                    </h6>
                  </a>
                </li>
                <li class="slick-bg">
                  <a href="#">
                    <img src="images/top-10/03.jpg" class="img-fluid w-100" alt="" />
                    <h6 class="iq-title"><a href="#">Scam 1992</a></h6>
                  </a>
                </li>
                <li class="slick-bg">
                  <a href="#">
                    <img src="images/top-10/04.jpg" class="img-fluid w-100" alt="" />
                    <h6 class="iq-title"><a href="#">Stranger Things</a></h6>
                  </a>
                </li>
                <li class="slick-bg">
                  <a href="#">
                    <img src="images/top-10/05.jpg" class="img-fluid w-100" alt="" />
                    <h6 class="iq-title"><a href="#">BoJack Horsemen</a></h6>
                  </a>
                </li>
                <li class="slick-bg">
                  <a href="#">
                    <img src="images/top-10/06.jpg" class="img-fluid w-100" alt="" />
                    <h6 class="iq-title"><a href="#">Peaky Blinders</a></h6>
                  </a>
                </li>
              </ul>
              <div class="vertical_s">
                <ul id="top-ten-slider-nav" class="list-inline p-0 m-0 d-flex align-items-center">
                  <li>
                    <div class="block-images position-relative">
                      <a href="#">
                        <img src="images/top-10/01.jpg" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>Harry Potter</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            10+
                          </div>
                          <span class="text-white">8 Parts</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="video/Harry Potter.mp4" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
							<a href="video/Harry Potter.mp4" class="btn btn-link"> Play Now </a>
                            
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="block-images position-relative">
                      <a href="#">
                        <img src="images/top-10/02.jpg" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>The Queen's Gambit</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            18+
                          </div>
                          <span class="text-white">1 Season</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="video/The Queen's Gambit.mp4" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
							<a href="video/The Queen's Gambit.mp4" class="btn btn-link"> Play Now </a>
                            
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="block-images position-relative">
                      <a href="#">
                        <img src="images/top-10/03.jpg" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>Scam 1992</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            12+
                          </div>
                          <span class="text-white">1 Season</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="video/Scam  1992.mp4" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
							<a href="video/Scam  1992.mp4" class="btn btn-link"> Play Now </a>
                            
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="block-images position-relative">
                      <a href="#">
                        <img src="images/top-10/04.jpg" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>Stranger Things</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            16+
                          </div>
                          <span class="text-white">3 Season</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="video/Stranger Things.mp4" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
							<a href="video/Stranger Things.mp4" class="btn btn-link"> Play Now </a>
                            
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="block-images position-relative">
                      <a href="#">
                        <img src="images/top-10/05.jpg" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>BoJack Horseman</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            15+
                          </div>
                          <span class="text-white">6 Season</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="video/BoJack Horseman.mp4" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
							<a href="video/BoJack Horseman.mp4" class="btn btn-link"> Play Now </a>
                            
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="block-images position-relative">
                      <a>
                        <img src="images/top-10/06.jpg" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>Peaky Blinders</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            20+
                          </div>
                          <span class="text-white">5 Season</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="video/Peaky Blinders.mp4" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
							<a href="video/Peaky Blinders.mp4" class="btn btn-link"> Play Now </a>
                          
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
	<!--trending start-->

	<!--Suggested Sports start-->
    <section id="iq-suggested" class="s-margin">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12 overflow-hidden">
            <div class="iq-main-header d-flex align-items-center justify-content-between">
              <h4 class="main-title">Suggested Sports</h4>
             
            </div>
            <div class="favorite-contens">
              <ul class="favorites-slider list-inline row p-0 mb-0">
                <!-- slide item 1 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/suggested/01.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Basketball </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">NBA</div>
                        <span class="text-white">SPorts</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Basketball.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                   
                  </div>
                </li>
                <!-- slide item 2 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/suggested/02.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> VolleyBall </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">PRO</div>
                        <span class="text-white">Sports</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Volleyball.mp4" class="btn btn-link"> Play Now </a>
                         
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 3 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/suggested/03.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Basketball </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">LSU</div>
                        <span class="text-white">Sports</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Basketball.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 4 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/suggested/04.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Cricket </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">T-20</div>
                        <span class="text-white">Sports</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Cricket.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 5 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/suggested/05.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Golf </a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">PGA</div>
                        <span class="text-white">Sports</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Golf.mp4" class="btn btn-link"> Play Now </a>
                         
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>
	<!--Suggested Sports end-->

    <!-- parallax section  -->
    <section id="parallex" class="parallax-window">
      <div class="container-fluid h-100">
        <div class="row align-items-center justify-content-center h-100 parallaxt-details">
          <div class="col-lg-4 r-mb-23">
            <div class="text-left">
              <a href="javascript:void(0)">
                <h1 class="parallax-heading">Avatar</h1>
              </a>
              <div class="parallax-ratting d-flex align-items-center mt-3 mb-3">
                <ul
                  class="ratting-start p-o m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                  <li>
                    <a href="#" class="text-primary"><i class="fa fa-star"></i></a>
                  </li>
                  <li>
                    <a href="#" class="text-primary"><i class="pl-2 fa fa-star"></i></a>
                  </li>
                  <li>
                    <a href="#" class="text-primary"><i class="pl-2 fa fa-star"></i></a>
                  </li>
                  <li>
                    <a href="#" class="text-primary"><i class="pl-2 fa fa-star"></i></a>
                  </li>
                  <li>
                    <a href="#" class="text-primary"><i class="pl-2 fa fa-star-half-o"></i></a>
                  </li>
                </ul>
                <span class="text-white ml-3">7.8(Imbd)</span>
              </div>
              <div class="movie-time d-flex align-items-center mb-3">
                <div class="badge badge-secondary p-1 mr-2">9+</div>
                <span class="text-white">2h 42min</span>
              </div>
              <p>
                A paraplegic Marine dispatched to the moon Pandora on a unique
                mission becomes torn between following his orders and
                protecting the world he feels is his home.
              </p>
              <div class="parallax-buttons">
                <a href="video/Avatar.mp4" class="btn btn-hover">Play Now</a>
                <a href="https://www.imdb.com/title/tt1630029" class="btn btn-link">More Details</a>
              </div>
            </div>
          </div>
          <div class="col-lg-8">
            <div class="parallax-img">
              <a href="#"><img src="images/parallax/avatar.jpg" alt="" class="img-fluid w-100" /></a>
            </div>
          </div>
        </div>
      </div>
    </section>


<!--reccomended for u-->
    <section id="iq-suggested" class="s-margin">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12 overflow-hidden">
            <div class="iq-main-header d-flex align-items-center justify-content-between">
              <h4 class="main-title">Recommended For You</h4>
             
            </div>
            <div class="favorite-contens">
              <ul class="favorites-slider list-inline row p-0 mb-0">
                <!-- slide item 1 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/tvthrillers/01.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a>The Martian</a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">15+</div>
                        <span class="text-white">2h 45min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/The Martian.mp4" class="btn btn-link"> Play Now </a>
                        
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 2 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/tvthrillers/02.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a>Unhinged</a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">7+</div>
                        <span class="text-white">2h 12min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Unhinged.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 3 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/tvthrillers/03.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a>Kingsman</a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">18+</div>
                        <span class="text-white">3h</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Kingsman.mp4" class="btn btn-link"> Play Now </a>
                         
                        </span>
                      </div>
                    </div>
                   
                  </div>
                </li>
                <!-- slide item 4 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/tvthrillers/04.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Casino Royale</a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">18+</div>
                        <span class="text-white">1h 55min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Casino Royale.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
                <!-- slide item 5 -->
                <li class="slide-item">
                  <div class="block-images position-relative">
                    <div class="img-box">
                      <img src="images/tvthrillers/05.jpg" class="img-fluid" alt="" />
                    </div>
                    <div class="block-description">
                      <h6 class="iq-title">
                        <a> Mision Impossible</a>
                      </h6>
                      <div class="movie-time d-flex align-items-center my-2">
                        <div class="badge badge-secondary p-1 mr-2">17+</div>
                        <span class="text-white">1h 35min</span>
                      </div>
                      <div class="hover-buttons">
                        <span class="btn btn-hover iq-button">
                          <i class="fa fa-play mr-1"></i>
						  <a href="video/Mission- Impossible.mp4" class="btn btn-link"> Play Now </a>
                          
                        </span>
                      </div>
                    </div>
                    
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>
 </div>

  <!-- main content ends  -->


  <footer class="iq-bg-dark">
    <div class="footer-top">
      <div class="container-fluid">
        <div class="row footer-standard">
          <div class="col-lg-5">
            <div class="widget text-left">
              <div>
                <ul class="menu p-0">
                  
                  <li><a href="#">Privacy-Policy</a></li>
                  <li><a href="#">FAQ</a></li>
                  <li><a href="#">About Us</a></li>
                </ul>
              </div>
            </div>
            <div class="widget text-left">
              <div class="textwidget">
                <p><small>"Browse and enjoy your favorite films anytime, anywhere. From blockbusters to hidden gems, explore a world of cinema at your fingertips."</small></p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 mt-4 mt-lg-0">
            <h6 class="footer-link-title">
              Follow Us:
            </h6>
            <ul class="info-share">
              <li>
                <a href="https://www.facebook.com/login.php">
                  <i>
                  <fa class="fa fa-facebook"></fa>
                </a>
              </li>
              <li>
                <a href="https://www.youtube.com/">
                  <i>
                  <fa class="fa fa-youtube"></fa>
                </a>
              </li>
              <li>
                <a href="https://www.instagram.com/">
                  <i>
                  <fa class="fa fa-instagram"></fa>
                </a>
              </li>
            </ul>
          </div>
          <div class="col-lg-3 col-md-6 mt-4 mt-lg-0">
            <div class="widget text-left">
              <div class="textwidget">
                <h6 class="footer-link-title">
                  Vidoora 
                </h6>
                <div class="d-flex align-items-center">
                  <a href="https://play.google.com/store/games?hl=en&pli=1"><img src="images/footer/01.jpg" alt=""></a>
                  <br>
                  <a href="https://www.apple.com/app-store/" class="ml-3"><img src="images/footer/02.jpg" alt=""></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </footer>

  <!-- js files  -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/slick.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/select2.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/slick-animation.min.js"></script>

  <script src="js/HomeJs.js"></script>
</body>

</html>