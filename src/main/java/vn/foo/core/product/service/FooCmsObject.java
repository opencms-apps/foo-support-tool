package vn.foo.core.product.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.util.CmsUUID;

public final class FooCmsObject {
    private static Log log = CmsLog.getLog(FooCmsObject.class);
    private static FooCmsObject fooObject;
    private CmsObject cmso;

    private FooCmsObject() {
        initClass();
    }

    public static FooCmsObject getInstance() {
        if (fooObject == null) {
            fooObject = new FooCmsObject();
        }
        return fooObject;
    }

    private void initClass() {
        try {
            cmso = OpenCms.initCmsObject("Guest");
            cmso.loginUser("Admin", "25251325");
        } catch (CmsException e) {
            log.error("can't login to cmso");
            cmso = null;
        }
    }

    public CmsObject getCmsObject() {
        return cmso;
    }

    public CmsResource getResource(String resourceId) {
        if (StringUtils.isBlank(resourceId) || cmso == null) {
            return null;
        }

        try {
            return cmso.readResource(CmsUUID.valueOf(resourceId));
        } catch (CmsException e) {
            log.error("error when read resource " + resourceId, e);
        }
        return null;
    }

    public String getResourcePath(String resourceId) {
        CmsResource resource = getResource(resourceId);
        if (resource == null) {
            return "";
        }
        return cmso.getSitePath(resource);
    }
}
