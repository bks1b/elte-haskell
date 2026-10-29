string GetStudentsImperative(List<Student> students) {
    var result = new List<string>();
    var passed = new List<Student>();
    foreach (var student in students)
        if (student.Grade > 1)
            passed.Add(student);
    passed.Sort((a, b) => b.Grade.CompareTo(a.Grade));
    for (int i = 0; i < 3 && i < passed.Count; i++)
        result.Add(passed[i].Name);
    return string.Join(", ", result);
}

// olvasható, SQL-szerű feldolgozás (SQL is deklaratív nyelv)
string GetStudentsFunctional(List<Student> students) => string.Join(", ", students
    .Where(student => student.Grade > 1)
    .OrderByDescending(student => student.Grade)
    .Take(3)
    .Select(student => student.Name));

var students = new List<Student> {
    new("hármas", 3),
    new("ötös", 5),
    new("egyes", 1),
    new("négyes", 4),
};
Console.WriteLine(GetStudentsImperative(students));
Console.WriteLine(GetStudentsFunctional(students));

record Student(string Name, int Grade);
