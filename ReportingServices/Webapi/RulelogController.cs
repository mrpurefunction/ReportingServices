using Model.RulelogS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ReportingServices
{
    public class RulelogController : ApiController
    {
        PetaPoco.Database db = new PetaPoco.Database("dbconn");

        // POST api/<controller>
        public BootRecord Post(BootRecord bootRecord)
        {
            PetaPoco.Sql sql = new PetaPoco.Sql();
            sql.Select("*").From("t_RulelogS_Des");
            sql.Where("pointname=@0", bootRecord.pointname);
            sql.Where("starttime=@0", bootRecord.starttime.ToString());
            sql.Where("endtime=@0", bootRecord.endtime.ToString());
            List<BootRecord> BootRecords = db.Fetch<BootRecord>(sql);
            if (bootRecord != null && BootRecords != null && BootRecords.Count > 0)
            {
                bootRecord.id = BootRecords.First().id;
                db.Update(bootRecord);
            }
            else
            {
                if (!String.IsNullOrEmpty(bootRecord.description))
                    db.Insert(bootRecord);
            }
            return bootRecord;
        }
    }
}