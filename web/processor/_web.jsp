<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Steve
  Date: 2020/4/10
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public Map getParamMap(String param)
    {
        String[] items = param.split("&");
        Map map =new HashMap();
        for (int i = 0; i < items.length; i++)
        {
            String[] item = items[i].split("=");
            if (item.length == 2)
            {
                map.put(item[0], item[1]);
            } else
            {
                continue;
            }
        }
        return map;
    }
%>
