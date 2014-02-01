function FindProxyForURL(url, host) {
	if (
		isPlainHostName(host) ||
		shExpMatch(host, "*.example.co.jp") ||
		host.match(/^(192\.168\|172\.(1[6-9]|2\d|3[0-1])|10\.\d+|127\.\d+)\.\d+\.\d+$/)
	) {
		return "DIRECT";
	}
	return "PROXY proxy.example.co.jp:18080";
}
