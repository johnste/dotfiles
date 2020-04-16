module.exports = {
  defaultBrowser: "Firefox",
  options: {
    // urlShorteners: [],
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
      match: /example3/,
      browser: () => {
        return {
          name: "Google Chrome",
          openInBackground: true,
        };
      },
    },
    {
      match: /example1/,
      browser: () => {
        return {
          name: "Google Chrome",
          openInBackground: true,
        };
      },
    },
    {
      match: /example2/,
      browser: () => {
        return {
          name: "Google Chrome",
          openInBackground: true,
        };
      },
    },

    {
      // Open workplace related sites in work browser
      match: [
        /unomaly/,
        /logicmonitor/,
        finicky.matchHostnames([
          "localhost",
          "xd.adobe.com",
          "docs.google.com",
          "app.teamtailor.com",
          "drive.google.com",
        ]),
      ],
      browser: "Google Chrome", // "Brave Browser", //, //"Firefox Developer Edition"
    },
  ],
};
