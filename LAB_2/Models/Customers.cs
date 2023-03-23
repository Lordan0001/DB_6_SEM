namespace LAB_2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Customers
    {
        public int Id { get; set; }

        [Required]
        [StringLength(254)]
        public string customerName { get; set; }

        [Required]
        [StringLength(254)]
        public string customerEmail { get; set; }

        [Column(TypeName = "money")]
        public decimal creditBalance { get; set; }
    }
}
