using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace LAB_2.Models
{
    public partial class MainContext : DbContext
    {
        public MainContext()
            : base("name=MainConnection")
        {
        }

        public virtual DbSet<Accounts> Accounts { get; set; }
        public virtual DbSet<Categories> Categories { get; set; }
        public virtual DbSet<Customers> Customers { get; set; }
        public virtual DbSet<Goods> Goods { get; set; }
        public virtual DbSet<History> History { get; set; }
        public virtual DbSet<Orders> Orders { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Customers>()
                .Property(e => e.creditBalance)
                .HasPrecision(19, 4);

            modelBuilder.Entity<Goods>()
                .Property(e => e.price)
                .HasPrecision(19, 4);
        }
    }
}
