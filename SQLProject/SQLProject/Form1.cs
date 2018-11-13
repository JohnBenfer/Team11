using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Transactions;

namespace SQLProject
{
    public partial class Form1 : Form
    {
        const string connectionString = "Server=mssql.cs.ksu.edu;Database=jergend;Integrated Security=SSPI;";

        public Form1()
        {
            InitializeComponent();
            ConnectionTest();
        }


        public void ConnectionTest()
        {
            using (var transaction = new TransactionScope())
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    using (var command = new SqlCommand("Homework4.InsertTest", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.AddWithValue("ClubName", "ACM");
                        command.Parameters.AddWithValue("ClubPurpose", "The Association for Computing Machinery is the professional organization for computer scientists.");

                        var param = command.Parameters.Add("ClubId", SqlDbType.Int);
                        param.Direction = ParameterDirection.Output;

                        connection.Open();

                        command.ExecuteNonQuery();

                        transaction.Complete();
                    }
                }
            }
        }



    }
}
