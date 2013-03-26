var search_data = {"index":{"searchIndex":["mrscs","headerhelper","main","receiver","sender","util","string","add_bch_header()","add_jma_header()","bin2bit()","bit2bin()","gen_checksum()","get_config_path()","get_mrscs_config()","get_parent_path()","get_yaml_config()","load_log_config()","logger()","new()","new()","new()","notify_delegate()","request_open()","request_send()","start()","start()","start()","start_mrscs()","mrscs"],"longSearchIndex":["mrscs","mrscs::headerhelper","mrscs::main","mrscs::receiver","mrscs::sender","mrscs::util","string","mrscs::headerhelper::add_bch_header()","mrscs::headerhelper::add_jma_header()","string#bin2bit()","string#bit2bin()","mrscs::headerhelper::gen_checksum()","mrscs::util::get_config_path()","mrscs::get_mrscs_config()","mrscs::util::get_parent_path()","mrscs::util::get_yaml_config()","mrscs::load_log_config()","mrscs::logger()","mrscs::main::new()","mrscs::receiver::new()","mrscs::sender::new()","mrscs::receiver#notify_delegate()","mrscs::sender#request_open()","mrscs::sender#request_send()","mrscs::main#start()","mrscs::receiver#start()","mrscs::sender#start()","mrscs::start_mrscs()",""],"info":[["Mrscs","","Mrscs.html","","<p>Mrscsアプリケーションのベースとなるモジュールです。各種共通メソッドとアプリケーション開始メソッドを保持します。\n"],["Mrscs::HeaderHelper","","Mrscs/HeaderHelper.html","","<p>送信データにヘッダを付与するためのヘルパークラス\n"],["Mrscs::Main","","Mrscs/Main.html","","<p>Mrscsのメイン処理\n"],["Mrscs::Receiver","","Mrscs/Receiver.html","","<p>Unixドメインソケットサーバを起動し外部からのデータを受信します。\nデータを受信した後はこのクラスで保持するdelegateインスタンスに受信データを連携します。\n"],["Mrscs::Sender","","Mrscs/Sender.html","","<p>データ送信用クラス\n"],["Mrscs::Util","","Mrscs/Util.html","","<p>アプリケーションで共通して使用するユーティリティメソッドを定義します。\n"],["String","","String.html","","<p>Stringクラス拡張\n"],["add_bch_header","Mrscs::HeaderHelper","Mrscs/HeaderHelper.html#method-c-add_bch_header","(data)","<p>BCHヘッダを付与\n<p>Args\n<p>data  &mdash; 送信データ\n"],["add_jma_header","Mrscs::HeaderHelper","Mrscs/HeaderHelper.html#method-c-add_jma_header","(data)","<p>JMAヘッダを付与\n<p>Args\n<p>data  &mdash; 送信データ\n"],["bin2bit","String","String.html#method-i-bin2bit","()","<p>バイナリを2進文字列に変換します。\n<p>Args\n<p>Return\n"],["bit2bin","String","String.html#method-i-bit2bin","()","<p>2進文字列をバイナリに変換します。\n<p>Args\n<p>Return バイナリ文字列\n"],["gen_checksum","Mrscs::HeaderHelper","Mrscs/HeaderHelper.html#method-c-gen_checksum","(str_bch)","<p>引数のBCH文字列からチェックサム値を作成\n<p>Args\n<p>_str_bch  &mdash; BCHの2進文字列表現\n"],["get_config_path","Mrscs::Util","Mrscs/Util.html#method-c-get_config_path","(file_path)","<p>configファイルが保存されているディレクトリパスを取得します。 引数で指定されたパスから “../config”\nでたどったパスにconfigが保存されていることが前提です。\n<p>Args …\n"],["get_mrscs_config","Mrscs","Mrscs.html#method-c-get_mrscs_config","()","<p>Mrscsアプリケーション用の各種設定を取得します。\n<p>Args\n<p>Return\n"],["get_parent_path","Mrscs::Util","Mrscs/Util.html#method-c-get_parent_path","(file_path)","<p>引数で指定されたパスの親ディレクトリのパスを取得します。\n<p>Args\n<p>file_path  &mdash; ディレクトリのパス(String)\n"],["get_yaml_config","Mrscs::Util","Mrscs/Util.html#method-c-get_yaml_config","(config_file_name)","<p>configディレクトリのYamlファイルをロードしてHash形式で取得します。\n<p>Args\n<p>config_file_name  &mdash; configファイル名称(configディレクトリ内のファイルであることが前提) …\n"],["load_log_config","Mrscs","Mrscs.html#method-c-load_log_config","()","<p>ロガーインスタンス用Log4rインスタンスを作成します。\n<p>Args\n<p>Return\n"],["logger","Mrscs","Mrscs.html#method-c-logger","()","<p>Mrscsアプリケーション用ロガーインスタンスを取得します。\n<p>Args\n<p>Return\n"],["new","Mrscs::Main","Mrscs/Main.html#method-c-new","(options)","<p>初期化\n<p>Args\n<p>options  &mdash; 起動時の設定\n"],["new","Mrscs::Receiver","Mrscs/Receiver.html#method-c-new","(options)","<p>初期化処理\n<p>Args\n<p>options  &mdash; 起動時の設定\n"],["new","Mrscs::Sender","Mrscs/Sender.html#method-c-new","(options)","<p>初期化処理\n<p>Args\n<p>options  &mdash; 設定ファイル内容\n"],["notify_delegate","Mrscs::Receiver","Mrscs/Receiver.html#method-i-notify_delegate","(data)","<p>デリゲート通知\n<p>Args\n<p>data  &mdash; デリゲートに通知するデータ\n"],["request_open","Mrscs::Sender","Mrscs/Sender.html#method-i-request_open","()","<p>サーバに接続する\n<p>Args\n<p>Return\n"],["request_send","Mrscs::Sender","Mrscs/Sender.html#method-i-request_send","(data)","<p>サーバへ送信要求を行う\n<p>Args\n<p>data  &mdash; 送信データ\n"],["start","Mrscs::Main","Mrscs/Main.html#method-i-start","()","<p>メイン処理開始\n<p>Args\n<p>Return\n"],["start","Mrscs::Receiver","Mrscs/Receiver.html#method-i-start","()","<p>Unixドメインソケットサーバを起動します。\n<p>Args\n<p>Return\n"],["start","Mrscs::Sender","Mrscs/Sender.html#method-i-start","()","<p>クライアント処理開始\n<p>Args\n<p>Return\n"],["start_mrscs","Mrscs","Mrscs.html#method-c-start_mrscs","()","<p>Mrscsアプリケーションを開始します。\n<p>Args\n<p>Return\n"],["mrscs","","bin/mrscs.html","","<p># get base directory  base_dir =\nFile.dirname(File.dirname(File.expand_path(__FILE__)))\n<p># load libraries …\n"]]}}