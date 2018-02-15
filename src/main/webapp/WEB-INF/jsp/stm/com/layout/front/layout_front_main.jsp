<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>CebuEssay</title>
<%@include file="../../sys/metalibs.jspf" %>
<%@include file="../../sys/csslibs.jspf" %>
<%@include file="../../sys/jslibs.jspf" %>
<script type="text/javascript">
function changeWorksPage(pageno){
	$("#services-page"+pageno).show();
	$("#services-page"+pageno).siblings(".main-services-list").hide();
	$("#services-paging"+pageno).addClass("on");
	$("#services-paging"+pageno).siblings("a").removeClass("on");
}
</script>
</head>

<body>
	<div id="wrapper">
	<tiles:insertAttribute name="header" />
	<!-- Contents -->
		<div id="contents">
			<table class="content-table">
				<tr>
					<td class="tbl-left-column">
						<!-- Left Contents -->
						<tiles:insertAttribute name="left" />
						<!-- //Left Contents -->
					</td>
					<td>
						<!-- Middle Contents -->
						<div class="content-center">
							<div class="welcome-box">
								<div class="welcome-box-left">
									<h2 class="article-title" id="textDestination">We only offer the best!</h2>
									<p><strong class="welcome-pre">WE GOT THE EDGE!</strong><br/>
									We <strong>ONLY</strong> hire and train <i>excellent writers</i> <strong>ONSITE</strong>! We do <strong class="txt-underline">NOT</strong> accept <strong class="txt-underline">ONLINE</strong> <i>freelance writers</i>, who would most likely write your papers without proper training and full knowledge about essay writing. We have our office fully equipped with academic materials where our full-time excellent writers work hard on your papers.</p>
								</div>
								<p class="guarantee">
									<img src="${img_src }/stm/img_guarantee.png" alt="100% guarantee" class="imgGuarantee"/>
								</p>
							</div>
						</div>
						<div class="main-services">
							<div class="main-services-top">
								<span class="main-services-icon">&nbsp;</span>
								<h3 class="main-services-title">Cebu Essay’s Services</h3>
								<div class="main-services-paging">
									<span class="services-bg">&nbsp;</span>
									<span class="services-paging-content">
										<a href="javascript:void(0);" onclick="changeWorksPage(1);" class="services-prev">Previous</a>
										<span>
											<a href="javascript:void(0);" class="on" onclick="changeWorksPage(1);" id="services-paging1">01</a>
											<a href="javascript:void(0);" onclick="changeWorksPage(2);" id="services-paging2">02</a>
										</span>
										<a href="javascript:void(0);" onclick="changeWorksPage(2);" class="services-next">Next</a>
									</span>
									<span class="services-bg right">&nbsp;</span>
								</div>
							</div>
							<ul class="main-services-list" id="services-page1">
								<li>
									<a href="admission_essay.php" class="img-services imgs1">Admission Essay</a>
									<a href="admission_essay.php" class="lbl-services">Admission Essay</a>
									<p>Written by an applicant to graduate school in response to an assignment posted in the graduate application.</p>
									<a href="admission_essay.php" class="services-button">&nbsp;</a>
								</li>
								<li>
									<a href="essay.php" class="img-services imgs2">Essay</a>
									<a href="essay.php" class="lbl-services">Essay</a>
									<p>A short piece of nonfiction: an editorial, a feature story, a critical study, and exerpt from a book.</p>
									<a href="essay.php" class="services-button">&nbsp;</a>
								</li>
								<li>
									<a href="term_paper.php" class="img-services imgs3">Term Paper</a>
									<a href="term_paper.php" class="lbl-services">Term Paper</a>
									<p>The main report written by a student for a particular class of subject in the middle of each school term.</p>
									<a href="term_paper.php" class="services-button">&nbsp;</a>
								</li>
								<li>
									<a href="research_paper.php" class="img-services imgs4">Research Paper</a>
									<a href="research_paper.php" class="lbl-services">Research Paper</a>
									<p>The culmination and final product of an involved process of research, critical thinking, and composition.</p>
									<a href="research_paper.php" class="services-button">&nbsp;</a>
								</li>
							</ul>
							<ul class="main-services-list" id="services-page2">
								<li>
									<a href="thesis.php" class="img-services imgs1">Thesis</a>
									<a href="thesis.php" class="lbl-services">Thesis</a>
									<p>A proposition that a person advances and offers to maintain an argument.</p>
									<a href="thesis.php" class="services-button">&nbsp;</a>
								</li>
								<li>
									<a href="dissertation.php" class="img-services imgs2">Dissertation</a>
									<a href="dissertation.php" class="lbl-services">Dissertation</a>
									<p>A form of formal discourse (written or oral) commonly required from students in any level.</p>
									<a href="dissertation.php" class="services-button">&nbsp;</a>
								</li>
								<li>
									<a href="coursework.php" class="img-services imgs3">Coursework</a>
									<a href="coursework.php" class="lbl-services">Coursework</a>
									<p>Pertains to the work performed by students at middle/high school or university.</p>
									<a href="coursework.php" class="services-button">&nbsp;</a>
								</li>
								<li>
									<a href="revision.php" class="img-services imgs4">Editing</a>
									<a href="revision.php" class="lbl-services">Editing</a>
									<p>Correcting the grammar and structure.</p>
									<a href="revision.php" class="services-button">&nbsp;</a>
								</li>
							</ul>
							<span class="mid-spacer">&nbsp;</span>
							<ul class="main-middle-buttons">
								<li>
									<a href="order.php" class="mid-button-img serv1">Order Now</a>		
									<p>Still thinking? Make an order now to experience our amazing writing service.</p>
									<span><a href="order.php" class="mid-button-link">ORDER NOW</a></span>
								</li>
								<li>
									<a href="javascript:void(window.open('https://cebuessay.com/livezilla/livezilla.php', '','width=600,height=600,left=0,top=0,resizable=yes,menubar=no,location=yes,status=yes,scrollbars=yes'));" class="mid-button-img serv2">Online Support</a>		
									<p>Have a question? We are happy to answer all your questions through our chat system.</p>
									<span><a href="javascript:void(window.open('https://cebuessay.com/livezilla/livezilla.php', '','width=600,height=600,left=0,top=0,resizable=yes,menubar=no,location=yes,status=yes,scrollbars=yes'));" class="mid-button-link">ONLINE SUPPORT</a></span>
								</li>
								<li>
									<a href="contactus.php" class="mid-button-img serv3">Contact Us</a>		
									<p>Have a problem? It is our pleasure to assist you resolving your problem.</p>
									<span><a href="contactus.php" class="mid-button-link">CONTACT US</a></span>
								</li>
							</ul>
							<div class="mid-blue-box">
								<h4>ORDER CUSTOM ESSAYS, RESEARCH PAPER, &amp; TERM PAPER</h4>
								<p>Pursuing a degree requires students to take comprehensive subjects making their study loads full and schedules hectic. Also, all colleges and universities require their students to write academic papers, which need additional time as making those papers need extensive research. Having undergone the same stage of the process, <strong>CebuEssay.com</strong> understands the need of the students when it comes to writing academic papers. Knowing the fact that students have more urgent matters to attend to such as regular examinations and daily recitations, <strong>CebuEssay.com</strong> aims to support the academic goals of students by providing quality custom essays. While writing academic papers requires effort and time, <strong>CebuEssay.com</strong> provides quality papers made by highly able writers and researchers. The goal of CebuEssay.com is to assist students in writing their essay projects to help them receive excellent grades and attain academic success. Throughout the years, <strong>CebuEssay.com</strong> has received commendations from customers, which show that the company has been efficient in complying with their standards and expectations.</p>
							</div>						
							<h4 class="main-article-tit">ASSURANCE OF A GOOD QUALITY ESSAY FOR EVERYONE WHO NEEDS IT</h4>
							<p class="main-article">Our essays are made with the assurance that these are free from grammar errors and plagiarism. Our essays are original as our writers are highly able in making their own write ups while following the set standards of academic writing. As our writers are accustomed to the educational system of both continents, they are able to comply with their writing standards and guidelines. Moreover, our writers are aware of the intellectual standards of universities and colleges, which make them highly efficient writers. With long years of experience, they are highly knowledgeable in almost all academic writing formats and linguistic patterns in various academic fields. They are able to fit their writing style according to the grade level and nationality of the student.</p>
							<h4 class="main-article-tit">ACHIEVING ACADEMIC SUCCESS ALL THE TIME</h4>
							<p class="main-article">Academic success is one of the most essential elements that would empower people and help them succeed in the workplace. Our writers are equipped with advanced research tools and knowledge to use those efficiently. We also have credible research sources because we have access to online libraries, both public and private. This explains why our essays are of top quality. When you order custom made essays from our writing agency, we will assure you that we will produce quality essays. For the reason that our writers are highly efficient, they can write essays on a wide variety of subjects. Thus, we encourage you to purchase custom made essays from us so that you can benefit from our excellent writing performance.</p>
							<p class="main-article">Research papers always consume time, effort, and money. For most students, writing academic papers is stressful, expensive, and confusing as it requires students to buy books or subscribe to libraries. Students also need to research and analyze the information gathered. In addition, structuring essays like scholarly journals is a mental strain. We understand the hassles that students will encounter, and we also understand that students need to make academic papers to pass the subject. For this reason, we take it as our mission and vision to assist students in making their research papers. In this way, we can help them achieve academic success.</p>
							<h4 class="main-article-tit">ORDER EXCELLENT ESSAYS COMMENDED BY PROFESSORS	</h4>
							<p class="main-article">Our company is composed of professional researchers and writers who write essays with passion and inspiration to help students attain academic excellence. For the reason that they are professionals, they are knowledgeable in almost all subject areas. As we are aware that your academic success depends on the quality of our papers, we make sure that you will get the best results possible. In addition, we offer the best support and service that you can have in writing essays. Our writers and researchers will assure you that you will get the best value of your money by providing you with quality essays. While making essays entails effort and time, we will help you achieve academic success by writing your essay projects.</p>
							<p class="main-article">Our professional group of essay writers and researchers will also provide you with fresh writing ideas. As they go over your topic, rest assured that the style, design and structure of your essays are all original. Furthermore, they also write with brevity and logic making your custom made essays both comprehensive and understandable. As we are a company of professional writers and researchers, we are aware of the writing standards and procedures that should be followed in order to meet your school requirements. We will also make sure that the final product has been proofread and edited to ensure your academic success.  By the time you receive your essay or research paper, it will be free of errors as it will be revised several times to ensure the quality of the content, structure, and language usage.</p>
							<p class="main-article">As we understand the importance of a college degree to your career as professionals, we make sure that you will get original essays to suit your academic needs. In this way, we will not only help you achieve academic success, but also help build your future. Thus, allow us to make your essay projects now. Order our custom made essays now and attain the commendations of your professors.</p>
							<h4 class="main-article-tit">GET THE TOP NOTCH CUSTOM RESEARCH PAPERS WE PROVIDE</h4>
							<p class="main-article">Writing research papers is a tiresome work as one has to undergo the different writing procedures. Furthermore, in writing essays, one needs to comply with the standards and guidelines of the writing process, which make writing both mentally and emotionally stressing. Devoting long hours to research and essay construction are both a mental and emotional strain as one has to think of the necessary things to write. Students need to gather, understand, and analyze the appropriate information needed to be able to make an effective and comprehensive research project. Additionally, depression always comes especially when you have used all your resources, and you are still not contented with the quality of your essay.</p>
							<p class="main-article"><strong class="blue">CebuEssay.com</strong> understands both the side of the professors requiring those essays and the students who cannot spend long hours writing essays. Our professional researchers and writers will help you achieve excellent grades for your essay projects. As they have the passion to write, they are highly enthusiastic in assisting students in the writing of their essays. With our high level of professionalism, our services and prices are above the prices and services offered by other writing agencies. If you have problems in writing essays, contact our professionals and get the best essays we have to offer.</p>
							<p class="main-article"><strong class="blue">CebuEssay.com</strong> is aiming to help everyone who has difficulty in writing their essays, research papers, solving their assignments and making their paper work projects due to some reasons that affect our everyday lives. Sometimes we are so stressed out in doing a lot of assignments at the same time that would lead to sleepless nights, relationship gaps, and health problems. We are happy to help you, thus, giving you enough time to sleep, share time with your loved ones, and a robust life to live.</p>
							<p class="main-article">We guarantee you the best quality product that would meet your requirements to achieve success. We only hire highly-skilled professionals from reputable universities that belong to the top classes of their batch. We abide in professionalism, timeliness and perfection.</p>
							<p class="main-article">We assure you that our writing is unique and we know the rules of avoiding plagiarism. We can solve any academic questions or problems that you will have with the aid of our partners that are currently teaching for that specific subject in reputable universities. We will give accurate answers with explanations for you to enhance your knowledge.</p>
							<div class="slider">
								<span class="slider-txt">Excellent Quality<br/>On Time Delivery<br />Plagiarism Free!</span>
								<a href="order.php"><img src="${img_src }/stm/btn/btn_order_now.png" width="176" height="54" alt="Order Now" /></a>
								<span class="slider-guarantee"><strong>100%</strong> GUARANTEED</span>
							</div>
						</div>
						<!-- //Middle Contents -->
					</td>
					<td class="tbl-right-column">
						<!-- Right Contents -->
						<tiles:insertAttribute name="right" />
					</td>
				</tr>
			</table>							
		</div>
		<!-- //Contents -->
	<tiles:insertAttribute name="footer" />
	</div>
</body>
</html>