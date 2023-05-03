using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LAB_3
{
    [Serializable]
    [Microsoft.SqlServer.Server.SqlUserDefinedType(Format.UserDefined, Name = "Route", MaxByteSize = 16)]
    public class DbTask
    {
        [Microsoft.SqlServer.Server.SqlProcedure]
        public static void ReadFile(string filePath)
        {
           // string filePath = @"D:/a.txt";
            using (StreamReader reader = new StreamReader(filePath))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    SqlContext.Pipe.Send(line);
                }
            }


            // SqlContext.Pipe.Send("some text");
        }
    }


}
