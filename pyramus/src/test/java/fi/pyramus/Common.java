package fi.pyramus;

import java.util.Map;

public final class Common {
  public static String CLIENT_ID = "854885cf-2284-4b17-b63c-a8b189535f8d";
  public static String CLIENT_SECRET = "cqJ4J1if8ca5RMUqaYyFPYToxfFxt2YT8PXL3pNygPClnjJdt55lrFs6k1SZ6colJN24YEtZ7bhFW29S";
  public static String REDIRECT_URL = "https://localhost:8443/oauth2ClientTest/success";
  public static String AUTH_URL = "https://dev.pyramus.fi:8443/users/authorize.page";
  public static String AUTH_CODE = "ff81d5b8500c773e7a1776a7963801e3";
  public static Map<String, String> ROLEAUTHS;
  static {
    ROLEAUTHS.put("GUEST", "ff81d5b8500c773e7a1776a7963801e4");
    ROLEAUTHS.put("USER", "ff81d5b8500c773e7a1776a7963801e5");
    ROLEAUTHS.put("STUDENT", "ff81d5b8500c773e7a1776a7963801e8");
    ROLEAUTHS.put("MANAGER", "ff81d5b8500c773e7a1776a7963801e6");
    ROLEAUTHS.put("ADMINISTRATOR", "ff81d5b8500c773e7a1776a7963801e7");
  }
}
