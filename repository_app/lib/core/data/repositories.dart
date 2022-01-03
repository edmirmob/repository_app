class Repositories {
  Repositories({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  final int? totalCount;
  final bool? incompleteResults;
  final List<Item>? items;

  factory Repositories.fromJson(Map<String, dynamic> json) => Repositories(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.owner,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? nodeId;
  final String? name;
  final String? fullName;
  final bool? private;
  final Owner? owner;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        nodeId: json["node_id"],
        name: json["name"],
        fullName: json["full_name"],
        description: json["description"],
        private: json["private"],
        owner: Owner.fromJson(json["owner"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class Owner {
  Owner({
    this.login,
    this.id,
    this.nodeId,
  });

  final String? login;
  final int? id;
  final String? nodeId;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
      );
}
