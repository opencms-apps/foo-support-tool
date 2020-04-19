package vn.foo.core.product.api;

import com.google.common.collect.ImmutableMap;
import org.apache.commons.logging.Log;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsProperty;
import org.opencms.file.CmsResource;
import org.opencms.flex.CmsFlexController;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.main.OpenCmsServlet;
import org.opencms.search.CmsSearchResource;
import org.opencms.search.solr.CmsSolrField;
import org.opencms.search.solr.CmsSolrIndex;
import org.opencms.search.solr.CmsSolrQuery;
import org.opencms.search.solr.CmsSolrResultList;
import vn.foo.core.common.Constants;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/opencms/shoppingcart")
public class ShoppingCartServlet extends OpenCmsServlet {
    private static Log log = CmsLog.getLog(ShoppingCartServlet.class);
    private CmsFlexController m_controller;

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) {
        try {
            m_controller = CmsFlexController.getController(req);
            CmsObject cmso = m_controller.getCmsObject();

            CmsSolrQuery solrQuery = new CmsSolrQuery(cmso, ImmutableMap.of(
                    "fq", new String[]{
                            "type:" + Constants.PRODUCT_INFO,
                            "parent-folders:\"/sites/foo-test-site/\""}
            ));
            CmsSolrIndex solrIndex = OpenCms.getSearchManager().getIndexSolr(CmsSolrIndex.DEFAULT_INDEX_NAME_ONLINE);
            CmsSolrResultList searchResources = solrIndex.search(cmso, solrQuery, true);
            for (CmsSearchResource searchResource: searchResources) {
                String pagePath = searchResource.getField(CmsSolrField.FIELD_PATH);
                log.debug("pagePath " + pagePath);
                CmsResource resource = cmso.readResource(cmso.getRequestContext().removeSiteRoot(pagePath));
                // todo something
                List<CmsProperty> properties = cmso.readPropertyObjects(resource, false);
            }

        }catch (Exception ex) {
            ex.printStackTrace();
        }

        log.debug("GET: ok ok ok ok");
        try {
            res.setStatus(200);
            res.getWriter().write("shoping cart here");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) {
        log.debug("POST: ok ok ok ok");
        try {
            res.setStatus(200);
            res.getWriter().write("ok");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
