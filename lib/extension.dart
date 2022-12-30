extension CapitalFirstLetter on String {
  String capitaliseFirstLetter() {
    if (this.isEmpty) return this;
    if (this.length == 1) return this.toUpperCase();
    return this.substring(0,1).toUpperCase()+this.substring(1).toLowerCase();
  }
}
