namespace LAB_2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Orders
    {
        public int Id { get; set; }

        [Required]
        [StringLength(254)]
        public string orderedProduct { get; set; }

        [Required]
        [StringLength(254)]
        public string client { get; set; }

        [Column(TypeName = "date")]
        public DateTime orderDate { get; set; }

        public int orderedCount { get; set; }
    }
}
