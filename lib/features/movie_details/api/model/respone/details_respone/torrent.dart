class Torrent {
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
    url: json['url'] as String?,
    hash: json['hash'] as String?,
    quality: json['quality'] as String?,
    type: json['type'] as String?,
    isRepack: json['is_repack'] as String?,
    videoCodec: json['video_codec'] as String?,
    bitDepth: json['bit_depth'] as String?,
    audioChannels: json['audio_channels'] as String?,
    seeds: json['seeds'] as int?,
    peers: json['peers'] as int?,
    size: json['size'] as String?,
    sizeBytes: json['size_bytes'] as int?,
    dateUploaded: json['date_uploaded'] as String?,
    dateUploadedUnix: json['date_uploaded_unix'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'hash': hash,
    'quality': quality,
    'type': type,
    'is_repack': isRepack,
    'video_codec': videoCodec,
    'bit_depth': bitDepth,
    'audio_channels': audioChannels,
    'seeds': seeds,
    'peers': peers,
    'size': size,
    'size_bytes': sizeBytes,
    'date_uploaded': dateUploaded,
    'date_uploaded_unix': dateUploadedUnix,
  };
}
