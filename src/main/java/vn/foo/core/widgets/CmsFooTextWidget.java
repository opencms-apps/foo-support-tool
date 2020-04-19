package vn.foo.core.widgets;

import org.apache.commons.logging.Log;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.i18n.CmsEncoder;
import org.opencms.i18n.CmsMessages;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.widgets.*;
import org.opencms.xml.content.I_CmsXmlContentHandler.DisplayType;
import org.opencms.xml.types.A_CmsXmlContentValue;

import java.util.Collections;
import java.util.List;
import java.util.Locale;

public class CmsFooTextWidget extends A_CmsWidget implements I_CmsADEWidget {
    private static Log log = CmsLog.getLog(CmsFooTextWidget.class);

    public CmsFooTextWidget() {
        this(6);
    }

    public CmsFooTextWidget(int rows) {
        super("" + rows);
    }

    public CmsFooTextWidget(String configuration) {
        super(configuration);
        log.debug("init " + configuration);
    }

    @Override
    public String getConfiguration(CmsObject cms, A_CmsXmlContentValue contentValue, CmsMessages messages, CmsResource resource, Locale contentLocale) {
        return getConfiguration();
    }

    @Override
    public List<String> getCssResourceLinks(CmsObject cms) {
        return null;
    }

    @Override
    public DisplayType getDefaultDisplayType() {
        return DisplayType.wide;
    }

    public String getDialogWidget(CmsObject cms, I_CmsWidgetDialog widgetDialog, I_CmsWidgetParameter param) {
        String id = param.getId();
        log.debug("find id {}" + id);
        StringBuffer result = new StringBuffer(16);

        result.append("<td class=\"xmlTd\">");
        result.append("<textarea class=\"xmlInput maxwidth");
        if (param.hasError()) {
            result.append(" xmlInputError");
        }
        result.append("\" name=\"" + id + "\" rows=\"10\" cols=\"60\" style=\"overflow:auto;\">");
        result.append(CmsEncoder.escapeXml(param.getStringValue(cms)));
        result.append("</textarea>");
        result.append("</td>");
        log.debug(result.toString());
        return result.toString();
    }

    @Override
    public String getInitCall() {
        // Return the name of the Java Script function to call for initializing the widget.
        return null;
    }

    @Override
    public List<String> getJavaScriptResourceLinks(CmsObject cms) {
        return Collections.singletonList(OpenCms.getLinkManager().substituteLink(cms,"/system/modules/vn.foo.core.product/resources/js/widgets.js"));
    }

    @Override
    public String getWidgetName() {
        return CmsFooTextWidget.class.getName();
    }

    @Override
    public boolean isInternal() {
        return false;
    }

    @Override
    public I_CmsWidget newInstance() {
        return new CmsFooTextWidget();
    }

}
