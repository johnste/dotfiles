module.exports = {
  defaultBrowser: "Firefox",
  options: {
    // urlShorteners: [],
    logRequests: true
  },
  rewrite: [
    {
      // handle Slack redirects
      match: ({ urlString }) =>
        urlString.startsWith("https://slack-redir.net/link?url="),
      url: ({ urlString }) =>
        decodeURIComponent(
          urlString.substring("https://slack-redir.net/link?url=".length)
        ),
    },
    {
      match: finicky.matchHostnames(["www.amazon.com"]),
      url: ({ url }) => ({
        ...url,
        host: "smile.amazon.com",
      }),
    },
  ],

  handlers: [
    {
      // Open spotify urls in
      match: finicky.matchHostnames("open.spotify.com"),
      browser: "Spotify",
    },


    {
      // Open workplace related sites in work browser
      match: [
        /mhdev/,
        /mathem/,
        /amazon/,
        /\baws\b/,
        finicky.matchHostnames([
          "www.figma.com",
          "127.0.0.1",
          "localhost",
          "xd.adobe.com",
          "www.google.com",
          "meet.google.com",
          "docs.google.com",
          "app.teamtailor.com",
          "drive.google.com",
          "mathem.atlassian.net",
          "slack.com"
        ]),
      ],
      browser: "Google Chrome", // "Brave Browser", //, //"Firefox Developer Edition"
    },
  ],
};
