package PROCESSOR;

import java.util.HashMap;
import java.util.Map;

public class _Web
{
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
}
