<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../sys/taglibs.jspf"%>
<%@ include file="../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnDownloadSample = function(file){
		document.Form_list.filename.value=file;
		document.Form_list.submit();
	}
</script>
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Editing</h2>
		</div>
	</div>
	<h4 class="process-title blue">The Need to Edit the Essay </h4>
	<p class="main-article">John Locke defines an essay as a "form of literature popular with thoughtful readers." In our opinion, an essay is a composition of words that establishes an argument from the writer’s perspective, which is a strategy used by teachers in assessing the level of knowledge and understanding of a student. Writing is not an easy task; however, this skill is vital to develop and improve the analytical skills of a writer. In essay writing, editing is the last part of the process wherein you recheck and refine your work to meet the professional standard. </p>
	<p class="main-article">The question now relies on the importance and necessity of editing an essay. First, it gives an opportunity for the writer to read the essay again and inspect if the flow of argument is logical in the text. Argument is imperative when writing an essay because, without it, your essay is considered a trash! Argument is a "line of discussion" where you present a case and provide concrete evidence. So how will the jury believe in your judgment if there is no proof? That’s why, editing is essential because it stimulates you to assess your work carefully. When your claim has no substance, the best thing to do is revise.</p>
	<p class="main-article">Second, editing allows the writer to polish her work by eliminating vague, incomplete, or meaningless sentences. It is inevitable that writers commit this mistake. You often write incomplete sentences due to the ideas running in your mind, which are difficult to catch or express. With the application of editing, the writer can grasp and rewrite the idea to make it a complete sentence. McLaren illustrated that the fastest marathon runner can only be victorious in a race. However, an essay should be given enough time in editing to form a valid and complete discussion. The writer must ensure that an essay contains organization, transition, coherence and unity. Generally, this means that the main theme connects with the body and conclusion. Remember that an essay should be organized, coherent, and brief to certify that it is complete and relevant.</p>
	<p class="main-article">Third, you must proofread your essay. It must be done after you recheck the logical flow of an argument because editing and proofreading cannot be done simultaneously. There is a tendency that errors will be unnoticed if you rely on the superficial text. Proofreading finds and corrects mistakes in spelling, punctuation, and subject-verb agreement. Oftentimes, you unintentionally commit errors in grammar such as subject and verb agreement. To correct this error, writers must edit and proofread their work before it reaches the readers. In the classroom setting, teachers are always particular with the correct usage of punctuation such as period, comma, colon, and semi-colon. Thus, the students are expected to exhibit professional skills when writing the essay.</p>
	<p class="main-article">Writing and editing are both skills that must be applied by students and professionals. They are crucial in the formation of the intellectual reasoning of individuals. Editing, as the last stage of the process, aids individuals in characterizing a perfect essay because it enables you to recheck and inspect the logical elements of text, to erase irrelevant sentences, and proofread to correct mistakes in punctuation, grammar, and spelling.</p>
	<form name="Form_list" method="post" action="/front/samples/download.do">
		<input type="hidden" name="filename" value="" />
	</form>
	<span class="essay-samples">
		<strong>SAMPLES:</strong>
		<c:forEach var="row" items="${revision_samples.list }" varStatus="i">
		<a href="javascript:void" onclick="fnDownloadSample('${row.file}')" class="txt-red">Sample ${i.index+1 }</a>
		</c:forEach>
	</span>
	<span class="essay-table-title">Prices</span>
	<table class="tbl-price">
		<tr>
			<th>Price Rule</th>
			<th><?php echo ($revisionwords * 1);?> words</th>
			<th><?php echo ($revisionwords * 2);?> words</th>
			<th><?php echo ($revisionwords * 3);?> words</th>
			<th><?php echo ($revisionwords * 4);?> words</th>
		</tr>
		<?php for($j=0; $j<count($revisionprices); $j++){
										$price = $revisionprices[$j]['price']; ?>
		<tr class="even">
			<td><?php echo $revisionprices[$j]['title'].' ('.str_replace(',', '-',$revisionprices[$j]['days']);?> days)</td>
			<td><?php echo ($price*1); ?> US $</td>
			<td><?php echo ($price*2); ?> US $</td>
			<td><?php echo ($price*3); ?> US $</td>
			<td><?php echo ($price*4); ?> US $</td>
		</tr>
		<?php } ?>
	</table>
	<div class="slider">
		<span class="slider-txt">Excellent Quality<br/>On Time Delivery<br />Plagiarism Free!</span>
		<a href="${configs.CONTEXT }/front/order/insert.do"><img src="${img_src }/stm/btn/btn_order_now.png" width="176" height="54" alt="Order Now" /></a>
		<span class="slider-guarantee"><strong>100%</strong> GUARANTEED</span>
	</div>
</div>