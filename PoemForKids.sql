-- 1 What grades are stored in the database?
SELECT * FROM Grade;

--2 What emotions may be associated with a poem?
SELECT * FROM Emotion;

--3 How many poems are in the database?
SELECT count(p.Id) 'poem total' FROM Poem p;

--4 Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT top 76 Author.Name
	FROM Author 
ORDER BY Author.Name;

--5 Starting with the above query, add the grade of each of the authors.
SELECT top 76 Author.*, Grade.Name AS Grade
	FROM Author
JOIN Grade on Author.GradeId = Grade.Id
ORDER BY Author.Name;

--6 Starting with the above query, add the recorded gender of each of the authors.
SELECT top 76 Author.Name AS AuthorName, Grade.Name AS Grade, Gender.Name
	FROM Author
JOIN Grade on Author.GradeId = Grade.Id
LEFT JOIN Gender on Author.GenderId = Gender.Id
ORDER BY Author.Name;

--7 What is the total number of words in all poems in the database?
SELECT sum(p.WordCount) 'total word count' 
	FROM Poem p;

--8 Which poem has the fewest characters?
SELECT top 1 Poem.CharCount, Poem.Title, Poem.TEXT
	From Poem
ORDER BY Poem.CharCount;

--9 How many authors are in the third grade?
SELECT count(*) [Authors in 3rd]
	FROM Author a
 WHERE a.GradeId = 3;

--10 How many authors are in the first, second or third grades?
SELECT count(*) [Authors in 1st, 2nd, 3rd]
 FROM Author a
  WHERE a.GradeId = 1
  OR a.GradeId = 2
  OR a.GradeId = 3;

--11 What is the total number of poems written by fourth graders?
SELECT count(p.id) [total poems]
	FROM Poem p
JOIN Author a ON a.id = p.AuthorId
JOIN Grade g ON a.GradeId = g.id
WHERE g.id = 4;

--12 How many poems are there per grade?
SELECT count(p.id) 'total poems', g.name
	FROM Poem p
JOIN Author a ON a.id = p.AuthorId
JOIN Grade g ON a.GenderId = g.id
GROUP BY g.Name;


--13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT count(a.id) [total author] , g.Name
	FROM Author a
JOIN Grade g on a.GradeId = g.Id
GROUP BY g.Name;

--14 What is the title of the poem that has the most words?
SELECT top 1 p.Title [poem with the most words] , p.WordCount
	FROM Poem p
ORDER BY p.WordCount desc;

--15 Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT top 5 count(p.AuthorId) [poems by author], a.Name
	FROM Poem p
JOIN Author a on p.AuthorId = a.Id
GROUP BY p.AuthorId, a.Name
ORDER BY [poems by author] desc;

--16 How many poems have an emotion of sadness?
SELECT count(pe.Id) [total sadness poem]
	FROM PoemEmotion pe
JOIN Emotion e ON e.id = pe.PoemId
WHERE e.Name = 'sadness';

--17 How many poems are not associated with any emotion?
SELECT count(p.id) 'emotionless poem'
	FROM Poem p
LEFT JOIN PoemEmotion pe on p.id = pe.PoemId
WHERE pe.PoemId IS NULL;

--18 Which emotion is associated with the least number of poems?
select top 1 count(pe.emotionId) 'emotion count', e.Name 'emotion cited the least'
from PoemEmotion pe
join Emotion e on pe.EmotionId = e.id
group by pe.EmotionId, e.Name
order by 'emotion count';

--19 Which grade has the largest number of poems with an emotion of joy?
select top 1 count(pe.id) 'happy poems', g.Name
from PoemEmotion pe
join Emotion e on pe.EmotionId = e.id
join Poem p on pe.PoemId = p.id
join Author a on a.id = p.AuthorId
join Grade g on g.id = a.GradeId
where e.Name = 'joy'
group by g.Name
order by 'happy poems' desc;

--20 Which gender has the least number of poems with an emotion of fear?
select count(pe.id) 'fearful poems', g.Name
from PoemEmotion pe
join Emotion e on pe.EmotionId = e.id
join Poem p on pe.PoemId = p.id
join Author a on a.id = p.AuthorId
join Gender g on g.id = a.GenderId
where e.Name = 'fear'
group by g.Name
order by 'fearful poems';
