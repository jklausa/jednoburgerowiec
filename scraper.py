import json
import requests
import re
from lxml import html

def questions_from_tree(tree):
  questions = tree.xpath('//div[@class="questions-question-text"]//text()')
  answers = tree.xpath("//ul[contains(concat(' ', normalize-space(@class),' '),'question-answers-list')]//li//text()")
  correct_answers = tree.xpath("//span[@class='question-answer-right']//text()")

  questions_filtered = [x for x in questions if not re.match("[0-9]+\.", x) and not x == "Bild anzeigen"]

  answers_mapped =  [answers[i:i + 4] for i in range(0, len(answers), 4)]

  correct_answers_index = [answers_mapped[index].index(answer) for index, answer in enumerate(correct_answers)]

  return [{"questionText": question,
           "answers": answers_mapped[index],
           "correct_answer_index": correct_answers_index[index]} for index, question in enumerate(questions_filtered)]


baseURL = "https://www.einbuergerungstest-online.eu/fragen/"
urlSuffixes = list(range(1, 11)) + ["be"]

allQuestions = []

for suffix in urlSuffixes:
  url = baseURL + str(suffix)

  file = requests.get(url)
  tree = html.fromstring(file.content)

  allQuestions.extend(questions_from_tree(tree))

json.dumps(allQuestions, indent=4, sort_keys=True)

