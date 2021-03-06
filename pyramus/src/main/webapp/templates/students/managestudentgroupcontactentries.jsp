<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head> 
    <title><fmt:message key="students.manageStudentGroupContactEntries.pageTitle"></fmt:message></title>
    <jsp:include page="/templates/generic/head_generic.jsp"></jsp:include>
    <jsp:include page="/templates/generic/tabs_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/datefield_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/ckeditor_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/scriptaculous_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/table_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/dialog_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/hovermenu_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/jsonrequest_support.jsp"></jsp:include>
    <jsp:include page="/templates/generic/locale_support.jsp"></jsp:include>    

    <!-- Used to render memo values with line breaks; for some reason this is the only approach that works -->
    <% pageContext.setAttribute("newLineChar", "\n"); %>

    <script type="text/javascript">
      function setupTabRelatedActions(studentGroupId) {
        var basicTabRelatedActionsHoverMenu = new IxHoverMenu($('basicTabRelatedActionsHoverMenuContainer'), {
          text: '<fmt:message key="students.manageStudentGroupContactEntries.basicTabRelatedActionsLabel"/>'
        });
    
        basicTabRelatedActionsHoverMenu.addItem(new IxHoverMenuLinkItem({
          iconURL: GLOBAL_contextPath + '/gfx/eye.png',
          text: '<fmt:message key="students.manageStudentGroupContactEntries.basicTabRelatedActionsViewStudentGroupLabel"/>',
          link: GLOBAL_contextPath + '/students/viewstudentgroup.page?studentgroup=' + studentGroupId  
        }));

        basicTabRelatedActionsHoverMenu.addItem(new IxHoverMenuLinkItem({
          iconURL: GLOBAL_contextPath + '/gfx/accessories-text-editor.png',
          text: '<fmt:message key="students.manageStudentGroupContactEntries.basicTabRelatedActionsEditStudentGroupLabel"/>',
          link: GLOBAL_contextPath + '/students/editstudentgroup.page?studentgroup=' + studentGroupId  
        }));
      }

      function onLoad(event) {
        // Setup basics
        setupTabRelatedActions(${studentGroup.id}); 
        
        var tabControl2 = new IxProtoTabs($('studentTabs'));

        resetEntryForm();

        <c:if test="${!empty param.activeTab}">
          tabControl.setActiveTab("${param.activeTab}");  
        </c:if>
      }

      function resetEntryForm() {
        var entryForm = $("newContactEntryForm");
        entryForm.entryType.value = 'OTHER';
        entryForm.entryCreatorName.value = '${loggedUserName}';
        var dField = getIxDateField("entryDate");
        if (dField != null)
          dField.setTimestamp(new Date().getTime());
        entryForm["entryText"].value = '';
        CKEDITOR.instances["entryText"].setData('');
        entryForm.entryId.value = '-1';
        entryForm.submitContactLogEntryButton.value = "<fmt:message key="students.manageStudentGroupContactEntries.newContactLogEntryBtn"/>";
      }

      function resetEntryForm2(event) {
        $('studentContactLogEditEntryTitle').hide();
        $('studentContactLogNewEntryTitle').show();
        Event.stop(event);
        resetEntryForm();
      }

      function editEntry(contactEntryId) {
        $('studentContactLogEditEntryTitle').show();
        $('studentContactLogNewEntryTitle').hide();
        JSONRequest.request("students/getgroupcontactentry.json", {
          parameters: {
            entryId: contactEntryId
          },
          onSuccess: function (jsonResponse) {
            var results = jsonResponse.results;
            var entryId = results.id;
            var studentGroupId = results.studentGroupId;
            var entryDate = new Date(results.timestamp);
            var creatorName = results.creatorName;
            var entryType = results.type;
            var entryText = results.text;

            var entryForm = $("newContactEntryForm");
            entryForm.entryType.value = entryType;
            entryForm.entryCreatorName.value = creatorName;
            var dField = getIxDateField("entryDate");
            if (dField != null) {
              if (entryDate != null)
                dField.setTimestamp(entryDate.getTime());
              else
                dField.setTimestamp(new Date().getTime());
            }
            entryForm["entryText"].value = entryText;
            CKEDITOR.instances["entryText"].setData(entryText);
            entryForm.entryId.value = entryId;
            entryForm.submitContactLogEntryButton.value = "<fmt:message key="students.manageStudentGroupContactEntries.editContactLogEntryBtn"/>";
          } 
        });
      }

      function saveEvent(event) {
        var entryForm = $("newContactEntryForm");
        var entryId = entryForm.entryId.value;
        
        if (entryId == -1)
          newContactEntryFormSubmit(event);
        else
          modifyContactEntryFormSubmit(event);        
      }

      function getEntryTypeName(entryType) {
        var entryTypeName = "???";
        
        if (entryType == 'OTHER')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.other"/>';
        else
        if (entryType == 'LETTER')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.letter"/>';
        else
        if (entryType == 'EMAIL')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.email"/>';
        else
        if (entryType == 'PHONE')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.phone"/>';
        else
        if (entryType == 'CHATLOG')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.chatlog"/>';
        else
        if (entryType == 'SKYPE')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.skype"/>';
        else
        if (entryType == 'FACE2FACE')
          entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.face2face"/>';
        else
          if (entryType == 'ABSENCE')
            entryTypeName = '<fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.absence"/>';

        return entryTypeName;
      }

      function archiveEntry(entryId) {
        var entryShort = $("entry." + entryId + ".text").textContent;
        entryShort = entryShort.stripScripts().stripTags().strip();
        entryShort = entryShort.truncate(20, "...");
        var url = GLOBAL_contextPath + "/simpledialog.page?localeId=students.manageStudentGroupContactEntries.archiveContactEntryConfirmDialogContent&localeParams=" + encodeURIComponent(entryShort);
        var dialog = new IxDialog({
          id : 'confirmRemoval',
          contentURL : url,
          centered : true,
          showOk : true,  
          showCancel : true,
          autoEvaluateSize: true,
          title : '<fmt:message key="students.manageStudentGroupContactEntries.archiveContactEntryConfirmDialogTitle"/>',
          okLabel : '<fmt:message key="students.manageStudentGroupContactEntries.archiveContactEntryConfirmDialogOkLabel"/>',
          cancelLabel : '<fmt:message key="students.manageStudentGroupContactEntries.archiveContactEntryConfirmDialogCancelLabel"/>'
        });
      
        dialog.addDialogListener(function(event) {
          switch (event.name) {
            case 'okClick':
              JSONRequest.request("students/archivegroupcontactentry.json", {
                parameters: {
                  entryId: entryId
                },
                onSuccess: function (jsonResponse) {
                  var entryItem = $('studentContactEntryItem.' + entryId);

                  if (entryItem != null)
                    entryItem.remove();                  
                }
              });   
            break;
          }
        });

        dialog.open();
      }
      
      function addEntryRow(entryId, entryDate, entryType, entryCreatorName, entryText) {
        var listDiv = $('contactEntries');
        var dateStr = getLocale().getDate(entryDate, false);

        var entryTypeName = getEntryTypeName(entryType);

        var newEntryDiv = listDiv.appendChild(new Element("div", {id: "studentContactEntryItem." + entryId, className: "studentContactEntryItem"}));
        var newEntryCaptionDiv = newEntryDiv.appendChild(new Element("div", {id: "entry." + entryId + ".caption", className: "studentContactEntryCaption"}));
        
        var newEntryCaptionDateSpan = new Element("span", { id: "entryDate." + entryId + ".caption", className: "studentContactEntryDate" });
        newEntryCaptionDateSpan.update(dateStr); 
        var newEntryCaptionTypeSpan = new Element("span", { id: "entryType." + entryId + ".caption", className: "studentContactEntryType" });
        newEntryCaptionTypeSpan.update(entryTypeName); 
        var newEntryCaptionCreatorSpan = new Element("span", { id: "entryCreator." + entryId + ".caption", className: "studentContactEntryCreator" });
        newEntryCaptionCreatorSpan.update(entryCreatorName); 

        newEntryCaptionDiv.appendChild(newEntryCaptionDateSpan); 
        newEntryCaptionDiv.appendChild(newEntryCaptionTypeSpan); 
        newEntryCaptionDiv.appendChild(newEntryCaptionCreatorSpan); 
        
        var buttonsDiv = newEntryDiv.appendChild(new Element("div", { className: "studentContactEntryButtons" }));
        buttonsDiv.appendChild(new Element("img", {
          id: "entry." + entryId + ".commentbtn", 
          className: "studentContactEntryEditButton iconButton", 
          src: "${pageContext.request.contextPath}/gfx/list-add.png", 
          onClick: "addComment(" + entryId + ")"
        }));
        buttonsDiv.appendChild(new Element("img", {
          id: "entry." + entryId + ".editbtn", 
          className: "studentContactEntryEditButton iconButton", 
          src: "${pageContext.request.contextPath}/gfx/accessories-text-editor.png", 
          onClick: "editEntry(" + entryId + ")"
        }));
        buttonsDiv.appendChild(new Element("img", {
          id: "entry." + entryId + ".archivebnt", 
          className: "studentContactEntryArchiveButton iconButton", 
          src: "${pageContext.request.contextPath}/gfx/edit-delete.png", 
          onClick: "archiveEntry(" + entryId + ")"
        }));

        var node = new Element("div", { id: "entry." + entryId + ".text" });
        node.update(entryText);
        newEntryDiv.appendChild(node);
       
        node = new Element("div", { id: "contactEntryComments." + entryId, className: "contactEntryCommentsWrapper" });
        newEntryDiv.appendChild(node);
      }
      
      /**
       * 
       *
       * @param event The submit event
       */
      function newContactEntryFormSubmit(event) {
        Event.stop(event);

        var entryForm = Event.element(event);
        JSONRequest.request("students/creategroupcontactentry.json", {
          parameters: {
            entryType: entryForm.entryType.value,
            entryCreatorName: entryForm.entryCreatorName.value,
            entryDate: entryForm["entryDate"].value,
            entryText: CKEDITOR.instances["entryText"].getData(),
            studentGroupId: entryForm.studentGroupId.value
          },
          onSuccess: function (jsonResponse) {
            window.location.reload();
          } 
        });
      }
      
      function modifyContactEntryFormSubmit(event) {
        Event.stop(event);

        var entryForm = Event.element(event);
        JSONRequest.request("students/editgroupcontactentry.json", {
          parameters: {
            entryType: entryForm.entryType.value,
            entryCreatorName: entryForm.entryCreatorName.value,
            entryId: entryForm.entryId.value,
            entryDate: entryForm["entryDate"].value,
            entryText: CKEDITOR.instances["entryText"].getData()
          },
          onSuccess: function (jsonResponse) {
            window.location.reload();
          } 
        });
      }
      
      // Comments
      
      function addComment(entryId) {
        resetCommentForm();
        
        var entryForm = $("newContactEntryCommentForm");
        entryForm.entryId.value = entryId;

        var parentNode = $("contactEntryComments." + entryId);
        showCommentForm(parentNode); 
      }
      
      function addCommentRow(entryId, commentId, commentDate, commentCreatorName, commentText) {
        var listDiv = $('contactEntryComments.' + entryId);
        var dateStr = getLocale().getDate(commentDate, false);

        var newEntryDiv = listDiv.appendChild(new Element("div", { id: "studentContactEntryCommentItem." + commentId, className: "studentContactCommentEntryItem" }));
        var newEntryCaptionDiv = newEntryDiv.appendChild(new Element("div", { id: "entry." + entryId + ".caption", className: "studentContactCommentEntryCaption" }));
        
        var newEntryCaptionDateSpan = new Element("span", { id: "commentDate." + commentId + ".caption", className: "studentContactCommentEntryDate" });
        newEntryCaptionDateSpan.update(dateStr); 
        var newEntryCaptionCreatorSpan = new Element("span", { id: "commentCreator." + commentId + ".caption", className: "studentContactCommentEntryCreator" });
        newEntryCaptionCreatorSpan.update(commentCreatorName);
        
        newEntryCaptionDiv.appendChild(newEntryCaptionDateSpan); 
        newEntryCaptionDiv.appendChild(newEntryCaptionCreatorSpan); 
        
        var buttonsDiv = newEntryDiv.appendChild(new Element("div", { className: "studentContactCommentEntryButtons" }));
        buttonsDiv.appendChild(new Element("img", { 
          id: "comment." + entryId + ".editbtn", 
          className: "studentContactEntryEditButton iconButton", 
          src: "${pageContext.request.contextPath}/gfx/accessories-text-editor.png", 
          onClick: "editComment(" + commentId + ", " + entryId + ")"
        }));
        buttonsDiv.appendChild(new Element("img", { 
          id: "comment." + entryId + ".archivebnt", 
          className: "studentContactEntryArchiveButton iconButton", 
          src: "${pageContext.request.contextPath}/gfx/edit-delete.png", 
          onClick: "archiveComment(" + commentId + ", " + entryId + ")"
        }));

        var node = new Element("div", { id: "comment." + commentId + ".text" });
        node.update(commentText);
        newEntryDiv.appendChild(node);
      }

      function saveEntryComment(event) {
        var entryForm = $("newContactEntryCommentForm");
        var commentId = entryForm.commentId.value;
        
        if (commentId == -1)
          newContactEntryCommentFormSubmit(event);
        else
          modifyContactEntryCommentFormSubmit(event);

        hideCommentForm();        
      }

      /**
       * 
       *
       * @param event The submit event
       */
      function newContactEntryCommentFormSubmit(event) {
        Event.stop(event);

        var entryForm = Event.element(event);
        JSONRequest.request("students/creategroupcontactentrycomment.json", {
          parameters: {
            commentCreatorName: entryForm.commentCreatorName.value,
            commentDate: entryForm["commentDate"].value,
            commentText: CKEDITOR.instances["commentText"].getData(),
            entryId: entryForm.entryId.value
          },
          onSuccess: function (jsonResponse) {
            window.location.reload();
          } 
        });
      }
      
      function modifyContactEntryCommentFormSubmit(event) {
        Event.stop(event);

        var entryForm = Event.element(event);
        JSONRequest.request("students/editgroupcontactentrycomment.json", {
          parameters: {
            commentId: entryForm.commentId.value,
            commentCreatorName: entryForm.commentCreatorName.value,
            commentDate: entryForm["commentDate"].value,
            commentText: CKEDITOR.instances["commentText"].getData()
          },
          onSuccess: function (jsonResponse) {
            window.location.reload();
          } 
        });
      }

      function resetCommentForm() {
        var entryForm = $("newContactEntryCommentForm");
        entryForm.commentCreatorName.value = '${loggedUserName}';

        // Set time to zero (UTC), same as with datepicker
        var commentDate = new Date();
        commentDate.setUTCHours(0, 0, 0, 0);
        
        entryForm["commentDate"].value = commentDate.getTime();
        entryForm["commentText"].value = '';
        CKEDITOR.instances["commentText"].setData('');
        entryForm.entryId.value = '-1';
        entryForm.commentId.value = '-1';
        entryForm.submitContactLogEntryButton.value = "<fmt:message key="students.manageStudentGroupContactEntries.newCommentBtn"/>";
      }

      function resetCommentForm2(event) {
        Event.stop(event);
        resetCommentForm();
        hideCommentForm();
      }

      function showCommentForm(parentNode) {
        var container = $("commentFormContainer");
        container.remove();
        
        parentNode.appendChild(container);

        container.show();

        var elementBottom = container.cumulativeOffset().top + container.getDimensions().height;
        var viewportBottom = document.viewport.getScrollOffsets().top + document.viewport.getDimensions().height;
        
        if (viewportBottom < elementBottom) {
          Effect.ScrollTo(container, { duration:'0.2', offset: -20 });
        }
      }

      function hideCommentForm() {
        var container = $("commentFormContainer");

        container.hide();
      }
      
      function editComment(commentId, entryId) {
        JSONRequest.request("students/getgroupcontactentrycomment.json", {
          parameters: {
            commentId: commentId
          },
          onSuccess: function (jsonResponse) {
            var results = jsonResponse.results;
            var commentId = results.id;
            var entryId = results.entryId;
            var entryDate = new Date(results.timestamp);
            var creatorName = results.creatorName;
            var entryText = results.text;

            var commentForm = $("newContactEntryCommentForm");
            commentForm.commentCreatorName.value = creatorName;
            commentForm["commentDate"].value = entryDate.getTime();
            commentForm["commentText"].value = entryText;
            CKEDITOR.instances["commentText"].setData(entryText);
            commentForm.entryId.value = entryId;
            commentForm.commentId.value = commentId;
            commentForm.submitContactLogEntryButton.value = "<fmt:message key="students.manageStudentGroupContactEntries.editCommentEntryBtn"/>";

            var parentNode = $("studentContactEntryCommentItem." + commentId);
            
            showCommentForm(parentNode); 
          } 
        });
      }

      function archiveComment(commentId, entryId) {
        var entryShort = $("comment." + commentId + ".text").textContent;
        entryShort = entryShort.stripScripts().stripTags().strip();
        entryShort = entryShort.truncate(20, "...");
        
        var url = GLOBAL_contextPath + "/simpledialog.page?localeId=students.manageStudentGroupContactEntries.archiveCommentConfirmDialogContent&localeParams=" + encodeURIComponent(entryShort);
        var dialog = new IxDialog({
          id : 'confirmRemoval',
          contentURL : url,
          centered : true,
          showOk : true,  
          showCancel : true,
          autoEvaluateSize: true,
          title : '<fmt:message key="students.manageStudentGroupContactEntries.archiveCommentConfirmDialogTitle"/>',
          okLabel : '<fmt:message key="students.manageStudentGroupContactEntries.archiveCommentConfirmDialogOkLabel"/>',
          cancelLabel : '<fmt:message key="students.manageStudentGroupContactEntries.archiveCommentConfirmDialogCancelLabel"/>'
        });
      
        dialog.addDialogListener(function(event) {
          switch (event.name) {
            case 'okClick':
              JSONRequest.request("students/archivegroupcontactentrycomment.json", {
                parameters: {
                  commentId: commentId
                },
                onSuccess: function (jsonResponse) {
                  var entryItem = $('studentContactEntryCommentItem.' + commentId);

                  if (entryItem != null)
                    entryItem.remove();                  
                }
              });   
            break;
          }
        });

        dialog.open();
      }
      
    </script>
  </head>

  <body onload="onLoad(event);">
    <jsp:include page="/templates/generic/header.jsp"></jsp:include>
  
    <h1 class="genericPageHeader"><fmt:message key="students.manageStudentGroupContactEntries.pageTitle" /> (${studentGroup.name})</h1>
  
    <div id="viewStudentViewContainer"> 
      <div class="genericFormContainer"> 
        <div class="tabLabelsContainer" id="studentTabs">
          <a class="tabLabel" href="#studentGroup">
            ${studentGroup.name}
          </a>
        </div>
    
        <div id="studentGroup" class="tabContent">
          <div id="basicTabRelatedActionsHoverMenuContainer" class="tabRelatedActionsContainer"></div>

          <div id="viewStudentViewContainer"> 
            <div class="genericFormContainer genericAbsolutePositioningWrapper"> 
              <div id="studentContactEntryList" class="studentContactEntryWrapper">
                <div class="studentContactLogViewTitle"><fmt:message key="students.manageStudentGroupContactEntries.contactLogEntriesTitle"/></div>
                <div id="contactEntries"></div>

                <script type="text/javascript">
                  <c:forEach var="contactEntry" items="${contactEntries}">
                    addEntryRow(
                        ${contactEntry.id}, 
                        ${contactEntry.entryDate.time}, 
                        '${contactEntry.type}', 
                        '${fn:escapeXml(contactEntry.creatorName)}', 
                        '${fn:replace(fn:replace(contactEntry.text, newLineChar, ""), "'", "\\'")}'
                    );
  
                    <c:forEach var="comment" items="${contactEntryComments[contactEntry.id]}">
                    <c:if test="${!comment.archived}">
                    addCommentRow(
                        ${comment.entry.id}, 
                        ${comment.id},
                        ${comment.commentDate.time}, 
                        '${fn:escapeXml(comment.creatorName)}', 
                        '${fn:replace(fn:replace(comment.text, newLineChar, ""), "'", "\\'")}'
                    );
                    </c:if>
                    </c:forEach>
                  </c:forEach>
                </script>
              </div>

              <div id="commentFormContainer" style="display: none" class="studentCommentContainer">
                <form method="post" id="newContactEntryCommentForm" onsubmit="saveEntryComment(event);">
                  <input type="hidden" name="entryId" value="-1"/>
                  <input type="hidden" name="commentId" value="-1"/>
                  <input type="hidden" name="commentCreatorName" value=""/>
                  <input type="hidden" name="commentDate" value=""/>
                  <div class="genericFormSection">  
                    <textarea name="commentText" cols="40" rows="4" ix:cktoolbar="studentContactEntryText" ix:ckeditor="true"></textarea>
                  </div>            
                  <div>
                    <input type="submit" name="submitContactLogEntryButton" value="<fmt:message key="students.manageStudentGroupContactEntries.newCommentBtn"/>">
                    <input type="button" name="clearContactLogEntryButton" value="<fmt:message key="students.manageStudentGroupContactEntries.resetCommentFormBtn"/>" onClick="resetCommentForm2(event);">
                  </div> 
                </form>
              </div>

              <div class="studentContactNewEntryWrapper">
                <div class="studentContactLogViewTitle" id="studentContactLogNewEntryTitle"><fmt:message key="students.manageStudentGroupContactEntries.contactLogNewEntryTitle"/></div>
                <div class="studentContactLogViewTitle" id="studentContactLogEditEntryTitle" style="display:none;"><fmt:message key="students.manageStudentGroupContactEntries.contactLogEditEntryTitle"/></div>
                <div class="studentContactNewEntryFormContainer">
                  <form method="post" id="newContactEntryForm" onsubmit="saveEvent(event);">
                    <input type="hidden" name="studentGroupId" value="${studentGroup.id}"/>
                    <input type="hidden" name="entryId" value="-1"/>

                    <div class="genericFormSection">                            
                      <jsp:include page="/templates/generic/fragments/formtitle.jsp">
                        <jsp:param name="titleLocale" value="students.manageStudentGroupContactEntries.contactEntry.typeTitle"/>
                        <jsp:param name="helpLocale" value="students.manageStudentGroupContactEntries.contactEntry.typeHelp"/>
                      </jsp:include> 
                      <select name="entryType">
                        <option value="OTHER"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.other"/></option>
                        <option value="LETTER"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.letter"/></option>
                          <option value="EMAIL"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.email"/></option>
                          <option value="PHONE"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.phone"/></option>
                          <option value="CHATLOG"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.chatlog"/></option>
                          <option value="SKYPE"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.skype"/></option>
                          <option value="FACE2FACE"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.face2face"/></option>
                          <option value="ABSENCE"><fmt:message key="students.manageStudentGroupContactEntries.contactEntry.types.absence"/></option>
                        </select>
                      </div>            
                      <div class="genericFormSection">                            
                        <jsp:include page="/templates/generic/fragments/formtitle.jsp">
                          <jsp:param name="titleLocale" value="students.manageStudentGroupContactEntries.contactEntry.fromTitle"/>
                          <jsp:param name="helpLocale" value="students.manageStudentGroupContactEntries.contactEntry.fromHelp"/>
                        </jsp:include> 
                        <input type="text" name="entryCreatorName"/>
                      </div> 
                      <div class="genericFormSection">                            
                        <jsp:include page="/templates/generic/fragments/formtitle.jsp">
                          <jsp:param name="titleLocale" value="students.manageStudentGroupContactEntries.contactEntry.dateTitle"/>
                          <jsp:param name="helpLocale" value="students.manageStudentGroupContactEntries.contactEntry.dateHelp"/>
                        </jsp:include> 
                        <input type="text" name="entryDate" ix:datefieldid="entryDate" class="ixDateField"/>
                      </div>
                      <div class="genericFormSection">                            
                        <jsp:include page="/templates/generic/fragments/formtitle.jsp">
                          <jsp:param name="titleLocale" value="students.manageStudentGroupContactEntries.contactEntry.textTitle"/>
                          <jsp:param name="helpLocale" value="students.manageStudentGroupContactEntries.contactEntry.textHelp"/>
                        </jsp:include> 
                        <textarea name="entryText" cols="60" rows="6" ix:cktoolbar="studentContactEntryText" ix:ckeditor="true"></textarea>
                      </div>            
                      <div>
                        <input type="submit" name="submitContactLogEntryButton" value="<fmt:message key="students.manageStudentGroupContactEntries.newContactLogEntryBtn"/>">
                        <input type="button" name="clearContactLogEntryButton" value="<fmt:message key="students.manageStudentGroupContactEntries.resetContactLogEntryFormBtn"/>" onClick="resetEntryForm2(event);">
                      </div> 
                    </form>
                  </div>
                </div>  
                <div class="columnClear"></div>         
              </div>
            </div>  
          </div>
      </div>
    </div>  

    <jsp:include page="/templates/generic/footer.jsp"></jsp:include>
  </body>
</html>