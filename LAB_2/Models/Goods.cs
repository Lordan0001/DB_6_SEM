namespace LAB_2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Goods
    {
        public int Id { get; set; }

        [Required]
        [StringLength(254)]
        public string productName { get; set; }

        [Required]
        [StringLength(254)]
        public string productCattegory { get; set; }

        public int count { get; set; }

        [Column(TypeName = "money")]
        public decimal price { get; set; }
    }
}
