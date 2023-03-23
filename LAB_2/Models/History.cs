namespace LAB_2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("History")]
    public partial class History
    {
        public int Id { get; set; }

        public int orderId { get; set; }

        [Required]
        [StringLength(254)]
        public string operation { get; set; }

        public DateTime createAt { get; set; }
    }
}
