

class Items
{
  String item_id;
  String item_baslik;
  String item_uzunmetin;
  String item_konu;
  String item_link;
  String item_tarih;
  String item_resim;
  String item_hafta;
  String kategori_ad;
  bool one_cikarilan;

  Items(
      this.item_id,
      this.item_baslik,
      this.item_uzunmetin,
      this.item_konu,
      this.item_link,
      this.item_tarih,
      this.item_resim,
      this.item_hafta,
      this.kategori_ad,
      this.one_cikarilan,
      );

  factory Items.fromJson(Map<String,dynamic> json)
  {
    return Items(json["id"],
        json["item_baslik"] as String,
        json["item_uzunmetin"] as String,
        json["item_konu"] as String,
        json["item_link"] as String,
        json["item_tarih"] as String,
        json["item_resim"] as String,
        json["item_hafta"] as String,
        json["kategori_ad"] as String,
        json["one_cikarilan"] as bool);
  }
}