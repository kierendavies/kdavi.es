Hyphenator.config({
  hyphenchar: " ",
  minwordlength: 1
})

String.prototype.hashCode = ->
  hash = 0
  for i in [0...this.length]
    char = this.charCodeAt(i)
    hash = ((hash << 5) - hash) + char
    hash = hash & hash
  hash

Number.prototype.mod = (n) ->
  ((this % n) + n) % n

@words = [
  "gullible", "foolish", "unsophisticated", "unsuspecting", "innocent",
  "silly", "simple", "sucker", "susceptible", "unwise", "stupid",
  "buffoon", "clown", "bozo", "fool", "idiot", "moron", "nitwit", "twit",
  "chump", "cretin", "dimwit", "dork", "dunce", "ignoramus", "imbecile",
  "kook", "nincompoop", "simpleton", "knobhead"
]

@translation = (name) ->
  Hyphenator.hyphenate(name, "en").split(" ").map (s) ->
    [s, words[s.toLowerCase().hashCode().mod(words.length)]]

@showTranslation = ->
  $("#result").removeClass("hidden")
  nameSyllables = $("#name-syllables").empty()
  nameTranslation = $("#name-translation").empty()
  for [syl, trn] in translation($("#name").val())
    nameSyllables.append($("<td>").text(syl))
    nameTranslation.append($("<td>").text(trn))


$ ->
  $("form#translate-name").submit (event) =>
    event.preventDefault()
    showTranslation()

