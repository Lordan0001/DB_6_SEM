namespace LAB_2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Categories
    {
        public int Id { get; set; }

        [Required]
        [StringLength(254)]
        public string category { get; set; }
    }
}
