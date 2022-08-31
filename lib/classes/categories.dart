class Kategoriler
{
  String  kategori_key;
  int kategori_sirasi;
  String kategori_ad;
  String kategori_resim;

  Kategoriler(this.kategori_key,this.kategori_sirasi,this.kategori_ad, this.kategori_resim);


  factory Kategoriler.fromJson(Map<String,dynamic> json)
  {
    return Kategoriler(json["id"],json["kategori_sirasi"]as int,json["kategori_ad"]as String,
        json["kategori_resim"] as String);
  }

}