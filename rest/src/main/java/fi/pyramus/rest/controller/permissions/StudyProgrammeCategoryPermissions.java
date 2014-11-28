package fi.pyramus.rest.controller.permissions;

import java.util.List;

import fi.muikku.security.Scope;
import fi.pyramus.security.impl.AbstractPyramusPermissionCollection;
import fi.pyramus.security.impl.DefaultPermissionRoles;
import fi.pyramus.security.impl.PermissionScope;
import fi.pyramus.security.impl.PyramusPermissionCollection;

public class StudyProgrammeCategoryPermissions extends AbstractPyramusPermissionCollection implements PyramusPermissionCollection {

  @Scope (PermissionScope.ENVIRONMENT)
  @DefaultPermissionRoles ({ ADMINISTRATOR, MANAGER })
  public static final String CREATE_STUDYPROGRAMMECATEGORY = "CREATE_STUDYPROGRAMMECATEGORY";
  
  @Scope (PermissionScope.ENVIRONMENT)
  @DefaultPermissionRoles ({ EVERYONE })
  public static final String LIST_STUDYPROGRAMMECATEGORIES = "LIST_STUDYPROGRAMMECATEGORIES";
  
  @Scope (PermissionScope.ENVIRONMENT)
  @DefaultPermissionRoles ({ EVERYONE })
  public static final String FIND_STUDYPROGRAMMECATEGORY = "FIND_STUDYPROGRAMMECATEGORY";
  
  @Scope (PermissionScope.ENVIRONMENT)
  @DefaultPermissionRoles ({ ADMINISTRATOR, MANAGER })
  public static final String UPDATE_STUDYPROGRAMMECATEGORY = "UPDATE_STUDYPROGRAMMECATEGORY";

  @Scope (PermissionScope.ENVIRONMENT)
  @DefaultPermissionRoles ({ ADMINISTRATOR })
  public static final String DELETE_STUDYPROGRAMMECATEGORY = "DELETE_STUDYPROGRAMMECATEGORY";
  
  
  
  @Override
  public List<String> listPermissions() {
    return super.listPermissions(StudyProgrammeCategoryPermissions.class);
  }

  @Override
  public boolean containsPermission(String permission) {
    return listPermissions().contains(permission);
  }

  @Override
  public String getPermissionScope(String permission) throws NoSuchFieldException {
    return super.getPermissionScope(StudyProgrammeCategoryPermissions.class, permission);
  }

  @Override
  public String[] getDefaultRoles(String permission) throws NoSuchFieldException {
    return super.getDefaultRoles(StudyProgrammeCategoryPermissions.class, permission);
  }

}
