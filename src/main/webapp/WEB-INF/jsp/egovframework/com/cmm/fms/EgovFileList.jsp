<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../../../stm/com/sys/taglibs.jspf"%>
<%@ include file="../../../../stm/com/sys/setCodes.jspf"%>

<c:if test="${param.readonly == 'Y'}">
	<c:choose>
		<c:when test="${fn:contains(param.url, '/back/') && !fn:contains(param.url, 'board/comment') && !fn:contains(param.url, '/back/portfolio')}">
			<div class="tr">
				<ul class="files">
					<c:forEach var="row" items="${fileList}" varStatus="i">
					<li>
						<span class="attachments">
							<span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span>
							<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}" />');" title="">${row.orignlFileNm }</a> [${row.fileMg } byte]
						</span>
					</li>
					</c:forEach>
				</ul>
			</div>
		</c:when>
		<c:when test="${fn:contains(param.url, '/back/portfolio')}">
			<tr>
				<th align="left" rowspan="2">썸네일(대)</th>
			</tr>
			<tr>
				<td>
					<div class="tr">
						<ul class="files">
							<c:forEach var="row" items="${fileList}" varStatus="i">
							<c:if test="${row.fileSn == '0' }">
							<li>
								<span class="attachments">
									<span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span>
									<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}" />');" title="">${row.orignlFileNm }</a> [${row.fileMg } byte]
								</span>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
			<tr>
				<th align="left" rowspan="2">썸네일(소)</th>
			</tr>
			<tr>
				<td>
					<div class="tr">
						<ul class="files">
							<c:forEach var="row" items="${fileList}" varStatus="i">
							<c:if test="${row.fileSn == '1' }">
							<li>
								<span class="attachments">
									<span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span>
									<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}" />');" title="">${row.orignlFileNm }</a> [${row.fileMg } byte]
								</span>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
			<tr>
				<th align="left" rowspan="2">샘플코드파일</th>
			</tr>
			<tr>
				<td>
					<div class="tr">
						<ul class="files">
							<c:forEach var="row" items="${fileList}" varStatus="i">
							<c:if test="${row.fileSn != '0' && row.fileSn != '1'}">
							<li>
								<span class="attachments">
									<span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span>
									<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}" />');" title="">${row.orignlFileNm }</a> [${row.fileMg } byte]
								</span>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/contact/online') }">
			<div class="attachment">
				<span class="upload-icon">&nbsp;</span>
				<div class="ufiles">
					<table class="files">
						<tbody>
							<c:forEach var="row" items="${fileList}" varStatus="i">
							<tr>
								<td>
									<div class="fileicon">
										<span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span>
										<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}" />');">${row.orignlFileNm }</a><span class="filesize"> [${row.fileMg } byte]</span>
									</div>												
								</td>
								<td class="btn-del-holder">
									<button class="btn-delete">삭제</button>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>	
			</div>
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/faq/list') }">
		<c:if test="${!empty fileList }">
		<div class="file-holder">
			 <span class="download-icon">&nbsp;</span>
			 <div class="downloadable-files">
			 	<ul>
			 		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			 		<li><span class="ico-${stmfn:extIcon('', fn:toLowerCase(fileVO.orignlFileNm)) }">&nbsp;</span><a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>')">${fileVO.orignlFileNm }</a> [${fileVO.fileMg } byte]</li>
			 		</c:forEach>
			 	</ul>
			 </div>
		</div>
		</c:if>
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/contact/view') }">
		<tr>
			<td>첨부파일</td>
			<td class="nopad">
				<ul class="attach-file">
					<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<li>
						<span class="icon-${stmfn:extIcon('', fn:toLowerCase(fileVO.orignlFileNm)) }">&nbsp;</span>
						<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>')">${fileVO.orignlFileNm }</a> [${fileVO.fileMg } byte]
					</li>
					</c:forEach>
				</ul>
			</td>						
		</tr>
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/project/board/view') }">
		<tr>
			<td>첨부파일</td>
			<td class="nopad">
				<c:if test="${!empty fileList }">
				<div class="attachment no-bdr">
					<div class="ufiles">
						<table class="files">
							<tbody>
								<c:forEach var="fileVO" items="${fileList}" varStatus="status">
								<tr>
									<td>
										<div class="fileicon">
											<span class="ico-${stmfn:extIcon('', fn:toLowerCase(fileVO.orignlFileNm)) }">&nbsp;</span>
											<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>')">${fileVO.orignlFileNm }</a> <span class="filesize"> [${fileVO.fileMg } byte]</span>
										</div>												
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>	
				</div>
				</c:if>
				<c:if test="${empty fileList }">						
			 	<div class="file-text bdr-top">첨부된 파일이 없습니다.</div>
			 	</c:if>
			</td>
		</tr>
		</c:when>
		<c:when test="${fn:contains(param.url, '/back/project/board/comment') || fn:contains(param.url, '/back/board/comment') }">
		<div class="section-bottom">
			<span class="download-icon-section">
				<img src="${img_src }/stm/back/${language }/ico/icon_downloads.png" alt="download"/>
			</span>
			<div class="downloadable-section">
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
				<div <c:if test="${status.last }">class="last-div"</c:if>>
					<span class="img-holder">
						<span class="icon-${stmfn:extIcon('', fn:toLowerCase(fileVO.orignlFileNm)) }">&nbsp;</span>
					</span>
					<span class="text">
						<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>')">${fileVO.orignlFileNm }</a>[${fileVO.fileMg } byte]
					</span>
				</div>
				</c:forEach>
			</div>
		</div>
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/project/board/comment') }">
		<div class="comment-attachement">
			<span class="icon-attached">
				<img src="${img_src }/stm/front/${language }/ico/ico_download.png" alt="icon">
			</span>
			
			<span class="attached-files">
				<ul class="comment-files">
					<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<li>
						<span class="file-icon">
							<span class="icon-${stmfn:extIcon('', fn:toLowerCase(fileVO.orignlFileNm)) }">&nbsp;</span>
						</span>
						<span class="filename">
							<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>')">${fileVO.orignlFileNm }</a>
							<span class="filesize"> [${fileVO.fileMg } byte]</span>
						</span>
					</li>
					</c:forEach>
				</ul>
			</span>
		</div>	
		</c:when>
		<c:otherwise>
		<tr>
			<th>File</th>
			<td>
				<c:forEach var="row" items="${fileList}" varStatus="i">
					<div>
						<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}"/>');">${row.orignlFileNm } (${row.fileMg })</a>
					</div>
				</c:forEach>
		    </td>
		</tr>
		<tr>
			<th>Thumbnail</th>
			<td>
				<c:forEach var="row" items="${fileList}" varStatus="i">
					<img src="${configs.CONTEXT}/cmm/fms/getImage.do?atchFileId=<c:out value="${cmd.atch_file_id}"/>&amp;fileSn=${row.fileSn }&amp;thumbSize=100" alt="" />
				</c:forEach>
		    </td>
		</tr>
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${param.readonly != 'Y'}">
	<c:choose>
		<c:when test="${fn:contains(param.url, '/back/') && !fn:contains(param.url, '/portfolio')}">
			<tr <c:if test="${fn:contains(param.url, '/back/contact/') }">class="no-border-bottom"</c:if>>
				<th <c:if test="${!empty fileList }">rowspan="2"</c:if> align="left">첨부파일</th>
				<td class="bg-td">
					<input type="file" name="file_1" id="egovComFileUploader" size="40"/>
					<input type="hidden" name="atch_file_id" id="atch_file_id" value="${param.atchFileId}"/>
					<div id="egovComFileList"></div>
				</td>
			</tr>
			<c:if test="${!empty fileList }">
			<tr <c:if test="${!fn:contains(param.url, '/back/faq/')}">class="no-border-bottom"</c:if>>
				<td colspan="" class="no-pad">
					
					<div class="tr">
						<span class="icon-uploaded">
							<img src="${img_src }/stm/back/${language }/ico/icon_uploaded_files.png" alt="icon uploaded"/>
						</span>
						<ul class="files">
							<c:forEach var="row" items="${fileList}" varStatus="i">
							<li id="file${row.fileSn}">
								<span class="icon-holder"><span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span></span>
								<div class="name-box">	
									${row.orignlFileNm} [${row.fileMg }]
								</div>
								<div class="button-holder">
									<button type="button" class="base-white delete-text" onclick="fn_egov_deleteFile('${row.atchFileId}', '${row.fileSn}');"><span>&nbsp;</span> 삭제</button>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>	
			</c:if>		
		</c:when>
		<c:when test="${fn:contains(param.url, '/back/portfolio')}">
			<tr>
				<th align="left">썸네일(대)</th>
				<c:if test="${empty fileList || fileList[0].fileSn != 0 }">
					<td class="bg-td">
						<input type="file" name="file_0" size="40"/>
						<input type="hidden" name="file_sns" value="0"/>
					</td>
				</c:if>
				<c:if test="${!empty fileList && fileList[0].fileSn == 0 }">
					<td colspan="" class="no-pad">
						
						<div class="tr">
							<span class="icon-uploaded">
								<img src="${img_src }/stm/back/${language }/ico/icon_uploaded_files.png" alt="icon uploaded"/>
							</span>
							<ul class="files">
								<c:forEach var="row" items="${fileList}" varStatus="i">
								<c:if test="${row.fileSn == 0 }">
								<li id="file${row.fileSn}">
									<span class="icon-holder"><span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span></span>
									<div class="name-box">	
										${row.orignlFileNm} [${row.fileMg }]
									</div>
									<div class="button-holder">
										<button type="button" class="base-white delete-text" onclick="fn_egov_deleteFileSn('${row.atchFileId}', '${row.fileSn}');"><span>&nbsp;</span> 삭제</button>
									</div>
								</li>
								</c:if>
								</c:forEach>
							</ul>
						</div>
					</td>
				</c:if>
			</tr>
			<tr>
				<th align="left">썸네일(소)</th>
				<c:if test="${empty fileList || (fileList[0].fileSn != 1 and fileList[1].fileSn != 1) }">
					<td class="bg-td">
						<input type="file" name="file_1" size="40"/>
						<input type="hidden" name="file_sns" value="1"/>
					</td>
				</c:if>
				<c:if test="${!empty fileList && (fileList[0].fileSn == 1 || fileList[1].fileSn == 1) }">
					<td colspan="" class="no-pad">
						
						<div class="tr">
							<span class="icon-uploaded">
								<img src="${img_src }/stm/back/${language }/ico/icon_uploaded_files.png" alt="icon uploaded"/>
							</span>
							<ul class="files">
								<c:forEach var="row" items="${fileList}" varStatus="i">
								<c:if test="${row.fileSn == 1 }">
								<li id="file${row.fileSn}">
									<span class="icon-holder"><span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span></span>
									<div class="name-box">	
										${row.orignlFileNm} [${row.fileMg }]
									</div>
									<div class="button-holder">
										<button type="button" class="base-white delete-text" onclick="fn_egov_deleteFileSn('${row.atchFileId}', '${row.fileSn}');"><span>&nbsp;</span> 삭제</button>
									</div>
								</li>
								</c:if>
								</c:forEach>
							</ul>
						</div>
					</td>
				</c:if>
			</tr>
			<tr>
				<th <c:if test="${!empty fileList }">rowspan="2"</c:if> align="left">샘플코드파일</th>
				<td class="bg-td">
					<input type="file" name="file_2" id="egovComFileUploader" size="40"/>
					<input type="hidden" name="atch_file_id" id="atch_file_id" value="${param.atchFileId}"/>
					<div id="egovComFileList"></div>
				</td>
			</tr>
			<c:if test="${!empty fileList }">
			<tr>
				<td colspan="" class="no-pad">
					<div class="tr">
						<span class="icon-uploaded">
							<img src="${img_src }/stm/back/${language }/ico/icon_uploaded_files.png" alt="icon uploaded"/>
						</span>
						<ul class="files">
							<c:forEach var="row" items="${fileList}" varStatus="i">
								<c:if test="${row.fileSn != 0 and row.fileSn != 1 }">
								<li id="file${row.fileSn}">
									<span class="icon-holder"><span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span></span>
									<div class="name-box">	
										${row.orignlFileNm} [${row.fileMg }]
									</div>
									<div class="button-holder">
										<button type="button" class="base-white delete-text" onclick="fn_egov_deleteFile('${row.atchFileId}', '${row.fileSn}');"><span>&nbsp;</span> 삭제</button>
									</div>
								</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>	
			</c:if>		
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/') && !fn:contains(param.url, '/front/contact/online/insert')}">
		<tr>
			<td>파일첨부</td>
			<td class="nopad">
			 	<c:if test="${!empty fileList }">
			 	<div class="attachment no-bdr">
					<div class="ufiles">
						<table class="files">
							<tbody>
								<c:forEach var="row" items="${fileList}" varStatus="i">
								<tr>
									<td>
										<div class="fileicon">
											<span class="icon-${stmfn:extIcon('', fn:toLowerCase(row.orignlFileNm)) }">&nbsp;</span>
											<a href="#">${row.orignlFileNm}</a> <span class="filesize"> [${row.fileMg } byte]</span>
										</div>												
									</td>
									<td class="btn-del-holder">
										<button type="button" class="btn-delete" onclick="fn_egov_deleteFile('${row.atchFileId}', '${row.fileSn}');">삭제</button>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>	
				</div>
				</c:if>
			 	<div class="file-upload<c:if test="${!empty fileList}"> bdr-top</c:if>">
			 		<input type="file" name="file_1" id="egovComFileUploader" title="파일첨부"/>
			 		<input type="hidden" name="atch_file_id" id="atch_file_id" value="${param.atchFileId }" />
			 		<div id="egovComFileList"></div>
			 	</div>
			 </td>
		</tr>
		</c:when>
		<c:when test="${fn:contains(param.url, '/front/contact/online/insert') }">
			<div class="section-details">
				<input type="file" name="file_1" id="egovComFileUploader" title="파일첨부" />
				<input type="hidden" name="atch_file_id" id="atch_file_id" value="${param.atchFileId}"/>
				<div id="egovComFileList"></div>
				<c:forEach var="row" items="${fileList}" varStatus="i">
					<div id="file${row.fileSn}">
						<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}"/>');">${row.orignlFileNm } (${row.fileMg })</a> <stmfn:button type="button" value="X" onclick="fn_egov_deleteFile('${row.atchFileId}', '${row.fileSn}');"/>
					</div>
				</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<tr>
				<th>샘플파일</th>
				<td>
					<input type="hidden" name="atch_file_id" id="atch_file_id" value="${param.atchFileId}"/>
					<input name="file_1" id="egovComFileUploader" type="file" title=""/>
					<div id="egovComFileList">
					</div>
					<c:forEach var="row" items="${fileList}" varStatus="i">
						<div id="file${row.fileSn}">
					
							<a href="javascript:fn_egov_downFile('<c:out value="${row.atchFileId}"/>','<c:out value="${row.fileSn}"/>');">${row.orignlFileNm } (${row.fileMg })</a> <stmfn:button type="button" value="X" onclick="fn_egov_deleteFile('${row.atchFileId}', '${row.fileSn}');"/>
						</div>
					</c:forEach>
			    </td>
			</tr>
		</c:otherwise>
	</c:choose>
</c:if>