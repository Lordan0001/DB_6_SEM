namespace LAB_2.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Accounts
    {
        public int Id { get; set; }

        [Required]
        [StringLength(254)]
        public string login { get; set; }

        [Required]
        [StringLength(254)]
        public string password { get; set; }

        [Required]
        [StringLength(254)]
        public string name { get; set; }

        [Required]
        [StringLength(254)]
        public string email { get; set; }
    }
}
