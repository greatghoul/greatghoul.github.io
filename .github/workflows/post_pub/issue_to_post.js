const matter = require("gray-matter")
const fs = require("fs");

const issue = JSON.parse(process.argv[2])
const { data, content } = matter(issue.body)
data.layout = 'post'
data.title = issue.title
data.tags = issue.labels.map(x => x.name)
data.issue = issue.number
data.slug = this.slug || data.issue

if (!data.date) {
  const date = new Date(issue.created_at)
  const dateOptions = { timeZone: "Asia/Shanghai", year: "numeric", month: "2-digit", day: "2-digit" }
  data.date = date.toLocaleString("zh-CN", dateOptions).replace(/\//g, "-")
}

const filename = `_posts/${data.date}-${data.slug}.md`
const filebody = matter.stringify(content, data)
fs.writeFile(filename, filebody, "utf-8", (err) => {
  if (err) throw err

  console.log(`Published to file ${filename}`)
})
