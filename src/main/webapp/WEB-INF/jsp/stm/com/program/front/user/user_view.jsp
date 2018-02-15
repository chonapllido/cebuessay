<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">My Page</h2>
		</div>
	</div>
	<span class="mypage-vm">Your Virtual Money: <span>US $<?php echo $virtual_money; ?></span></span>
	<form name="form_mypage" method="post" action="mypage.php">
	<table cellpadding="0" cellspacing="0" class="tbl-forum">
		<tr>
			<th width="8%">No</th>
			<th width="10%">Order No</th>
			<th width="10%">Type</th>
			<th width="11%">Date</th>
			<th width="11%">Deadline</th>
			<th width="11%">Writer</th>
			<th width="9%">Price</th>
			<th width="8%">Result</th>
			<th width="11%">Statsu</th>
			<th width="11%" class="last">Action</th>
		</tr>
		<?php 
		if(count($arr_info) > 0){		
									for($i=0; $i<count($arr_info); $i++){
									
									$file_db = explode(":", $arr_info[$i]['file']);
									$file_dir = explode(":", $arr_info[$i]['file_upload']);
									
									// color coding for the status
									switch($arr_info[$i]['status']){
										case "Pending":
											$class = "txt-blue";
											break;
										case "Paid":
											$class = "txt-orange";
											break;
										case "Working":
											$class = "txt-green";
											break;
										case "Finished":
											$class = "txt-pink";
											break;
										default:
											$class = "txt-red";
									}
											
									if($arr_info[$i]['type'] == "Essay"){
										$url = "order_form_essay_view.php?id=".$arr_info[$i]['id'];
										$dn_dir = "results/essay/";
									} else {
										$url = "order_form_revision_view.php?id=".$arr_info[$i]['id'];
										$dn_dir = "results/revision/";
									}
								?>
		<tr>
			<td><?php echo $cnt; ?></td>
			<td><?php echo $arr_info[$i]['order_id']; ?></td>
			<td><?php echo $arr_info[$i]['type']; ?></td>
			<td><?php echo $arr_info[$i]['date']; ?></td>
			<td><?php echo $arr_info[$i]['deadline']; ?></td>
			<td>&nbsp;<?php echo $arr_info[$i]['writer']; ?></td>
			<td><?php echo $arr_info[$i]['total']; ?> $</td>
			<td>
			<?php if( ($arr_info[$i]['result'] != '')  
											&& (file_exists($dn_dir.$arr_info[$i]['result'])) 
											&& $arr_info[$i]['status'] == 'Finished'){ ?>
			<input type="image" src="images/btn/btn-download.png" width="22" height="22" onclick="JSMypage.download('<?php echo $arr_info[$i]['type'];?>', '<?php echo $arr_info[$i]['result'];?>', 2);return false;" />
			<?php } else { ?>
				&nbsp;
			<?php } ?>
			</td>
			<td><span class="<?php echo $class; ?>"><?php echo $arr_info[$i]['status']; ?></span></td>
			<td>
				<a href="<?php echo $url; ?>"><img src="images/btn/btn_info.png" width="16" height="16" alt="information" /></a>&nbsp;&nbsp;
				<?php if($arr_info[$i]['status'] == 'Finished' || $arr_info[$i]['status'] == 'Cancelled' ){ ?>
				<a href="javascript:JSMypage.promptDelete('<?php echo $arr_info[$i]['order_id']; ?>');"><img src="images/btn/btn_remove.png" width="16" height="16" alt="delete" /></a>
				<?php } ?>
			 </td>
		</tr>
		<?php $cnt++; }} else { ?>
		<tr>
			<td colspan="10">No Orders Found!</td>
		</tr>
		<?php } ?>
	</table>
	<div class="paging"><?php echo $prev.$nav.$next; ?></div>
	
	<div class="list-search">
		<label for="order_no">Order No:</label>
		<input type="text" name="search_txt" id="search_txt" value="<?php echo $order_id;?>" />
		<input type="image" src="images/btn/btn_search.png" onclick="JSMypage.searchOrder('<?php echo $page; ?>');"  alt="search" class="btn-list-search" />
	</div>
	<input type="hidden" name="order_type" value="" />
	<input type="hidden" name="file" value="" />
	<input type="hidden" name="file_upload" value="" />
	<input type="hidden" name="task" value="2" />
	</form>
	<div class="faq">
		<big class="essay-type-title">Legend</big>
		<ul class="faq-list">
			<li>
				<span class="faq-question"><?php echo TYPE; ?></span>
				<span class="faq-answer">The type of order. It could be essay or revision.</span>
			</li>
			<li>
				<span class="faq-question"><?php echo DATE; ?></span>
				<span class="faq-answer">The date it has been ordered</span>
			</li>
			<li>
				<span class="faq-question"><?php echo DEADLINE; ?></span>
				<span class="faq-answer">The deadline of the order to be submitted.</span>
			</li>
			<li>
				<span class="faq-question"><?php echo RESULT; ?></span>
				<span class="faq-answer">The finished essay or revision. The file CebuEssay uploaded</span>
			</li>
			<li>
				<span class="faq-question"><?php echo STATUS; ?></span>
				<span class="faq-answer">The status of the order. It could be pending, paid, working, finished or cancelled.</span>
			</li>
			<li>
				<span class="faq-question"><?php echo PROCESS; ?></span>
				<span class="faq-answer">The Process column has two buttons, the information button and delete button. Click the information button&nbsp;&nbsp;<img src="images/btn/btn_info.png" width="16" height="16" alt="information" />&nbsp;&nbsp;to show the order details. Click the delete button&nbsp;&nbsp;<img src="images/btn/btn_remove.png" width="16" height="16" alt="delete" />&nbsp;&nbsp;if you want to delete the order.</span>
			</li>
		</ul>
	</div>
</div>