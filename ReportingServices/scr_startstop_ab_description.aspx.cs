using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.RulelogS;
using Wuqi.Webdiyer;

namespace ReportingServices
{
    public partial class scr_startstop_ab_description : System.Web.UI.Page
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                dataBind(1);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        public void dataBind(int pageIndex = 1, int pageSize = 10)
        {
            PetaPoco.Sql sql = new PetaPoco.Sql();
            sql.Select("m.[description] as name,a.*,b.description").From("SCR_StartStop_AB a");
            sql.LeftJoin("t_RulelogS_Des b").On("b.pointname=a.pointname and b.starttime=a.starttime and b.endtime=a.endtime");
            sql.LeftJoin("Point_Machine_Map m").On("m.pointname=a.pointname");
            // Create a PetaPoco database object
            var db = new PetaPoco.Database("dbconn");
            PetaPoco.Page<BootRecordSelect> pageitems = db.Page<BootRecordSelect>(pageIndex, pageSize, sql);
            rpt_RulelogS_Des.DataSource = pageitems.Items;
            rpt_RulelogS_Des.DataBind();
            AspNetPager1.RecordCount = (int)pageitems.TotalItems;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="src"></param>
        /// <param name="e"></param>
        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            //e.NewPageIndex;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="src"></param>
        /// <param name="e"></param>
        protected void AspNetPager1_PageChanged(object src, EventArgs e)
        {
            dataBind(AspNetPager1.CurrentPageIndex);
        }
    }
}