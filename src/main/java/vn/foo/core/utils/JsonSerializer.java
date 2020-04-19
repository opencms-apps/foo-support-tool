package vn.foo.core.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.util.*;

public class JsonSerializer {
    public static Logger log = LoggerFactory.getLogger(JsonSerializer.class);

    public static String object2Json(Object o) {
        if (o == null) {
            return "";
        }
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.writeValueAsString(o);
        } catch (Exception e) {
            log.debug("error {}", e);
            return "";
        }
    }

    public static void object2JsonIntoFile(Object o, boolean pretty, File dest) {
        if (o == null) {
            return;
        }
        ObjectMapper mapper = new ObjectMapper();
        try {
            if (pretty) {
                mapper.writerWithDefaultPrettyPrinter().writeValue(dest, o);
            }
            mapper.writeValueAsString(o);
        } catch (Exception e) {
            log.debug("error {}", e);
            return ;
        }
    }

    public static <T> T json2Object(String json, Class<T> clazz) {
        if (StringUtils.isBlank(json)) {
            return null;
        }
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(json, clazz);
        } catch (IOException e) {
            log.error("has error when parse json {}", e);
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> Map<String, T> json2Map(String json, Class<T> clazz) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(json, new TypeReference<Map<String,T>>(){});
        } catch (IOException e) {
            log.error("has error when parse json {}", e);
            return new LinkedHashMap();
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> List<T> json2List(String json, Class<T> clazz) {
        if (StringUtils.isBlank(json)) {
            return new ArrayList<>();
        }
        ObjectMapper mapper = new ObjectMapper();
        try {
            Class<T[]> arrayClass = (Class<T[]>) Class.forName("[L" + clazz.getName() + ";");
            T[] objects = mapper.readValue(json, arrayClass);
            return Arrays.asList(objects);
        } catch (Exception e) {
            log.error("has error when parse json {}", e);
            return new ArrayList<>();
        }
    }
}