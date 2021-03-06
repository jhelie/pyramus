<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>
<t:setupwizard-template>
	<jsp:attribute name="script">
</jsp:attribute>
	<jsp:body>
<form method="post" action="" ix:pageform="true">
		<div class="tabContent">
            <div class="genericFormSection">  
              <jsp:include
							page="/templates/generic/fragments/formtitle.jsp">
                <jsp:param name="titleLocale"
								value="system.setupwizard.adminpassword.usernameTitle" />
                <jsp:param name="helpLocale"
								value="system.setupwizard.adminpassword.usernameHelp" />
              </jsp:include>                  
              <input type="text" name="username" class="required"
							size="25" />
            </div>
            <div class="genericFormSection">  
              <jsp:include
							page="/templates/generic/fragments/formtitle.jsp">
                <jsp:param name="titleLocale"
								value="system.setupwizard.adminpassword.passwordTitle" />
                <jsp:param name="helpLocale"
								value="system.setupwizard.adminpassword.passwordHelp" />
              </jsp:include>    
              <input type="password" name="password1" class="required equals equals-password2" size="25">
            </div>
            <div class="genericFormSection">  
              <jsp:include
							page="/templates/generic/fragments/formtitle.jsp">
                <jsp:param name="titleLocale"
								value="system.setupwizard.adminpassword.password2Title" />
                <jsp:param name="helpLocale"
								value="system.setupwizard.adminpassword.password2Help" />
              </jsp:include>    
              <input type="password" name="password2" class="required equals equals-password1" size="25">
            </div>
            <div class="genericFormSection">  
              <jsp:include
							page="/templates/generic/fragments/formtitle.jsp">
                <jsp:param name="titleLocale"
								value="system.setupwizard.adminpassword.firstNameTitle" />
                <jsp:param name="helpLocale"
								value="system.setupwizard.adminpassword.firstNameHelp" />
              </jsp:include>    
              <input type="text" name="firstName" class="required" size="25">
            </div>
            <div class="genericFormSection">  
              <jsp:include
							page="/templates/generic/fragments/formtitle.jsp">
                <jsp:param name="titleLocale"
								value="system.setupwizard.adminpassword.lastNameTitle" />
                <jsp:param name="helpLocale"
								value="system.setupwizard.adminpassword.lastNameHelp" />
              </jsp:include>    
              <input type="text" name="lastName" class="required" size="25">
            </div>
        </div>
    <div class="genericFormSubmitSectionOffTab">
        <input type="submit" class="formvalid" name="next"
							value="<fmt:message key="system.setupwizard.next"/>">
    </div>
</form>

	
	</jsp:body>
</t:setupwizard-template>
